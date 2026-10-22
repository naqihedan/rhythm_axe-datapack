# 玻璃扫掠碰撞检测（CCD，@s = 玻璃交互实体；每 tick 由 active_note 在位置更新之后调用）
# ★ 2026-10-22 重写：锚 = 交互实体自身。
#   Pos = 视觉中心 − size/2（脚底）、Rotation = 运动方向（summon 从展示实体复制）、
#   note_prev_tz / note_prev2_tz = 局部 z 历史（move_self / move_write_pair 每刻滚动）。
#   ★ 为什么不再锚展示实体：往展示实体写 NBT 会把它标脏 → 向客户端同步，而游玩侧线性玻璃的视觉
#     完全依赖 motion/start 一次性下发的客户端插值（服务器此后刻意不再写 NBT）⇒ 每刻同步会打断插值。
#     症状：玻璃视觉比编辑器慢一截、寿命到点还没走到判定位置就出窗（2026-10-22 用户实测确认）。
#     交互实体不渲染，写它的 data 不影响视觉；且它本来每刻被 move_self 写 Pos（已同步），不新增包。
# 扫掠段 = [P(T-2), P(T-1)]（退 1 刻对齐视觉路径）：
#   note_prev2_tz = T-2 的局部 z（段起点）、note_prev_tz = T-1 的局部 z（段终点）
#   ★ 必须在 move_self / move（move_write_pair）之后：此刻历史刚从 T-2/T-1 滚动到位。
# 步进：从段起点沿朝向每前进 1 格做一次检测，共 d 步（d = 段长，cm 尺度）
#   步长 1.0 不隧穿：单点判定体 = 玩家判定箱各轴外扩 0.25（XZ 宽 0.6+0.5=1.1 > 1.0）→ 相邻覆盖区重叠
#   停住语义：d=0 时只测起点单点（= 玻璃当前停留位置），玩家碰到照常扣血

# ---- 1. 段长 d（cm）= |T-1 − T-2| 的局部 z 差 ----
scoreboard players operation #sw_d play_state = @s note_prev_tz
scoreboard players operation #sw_d play_state -= @s note_prev2_tz
execute if score #sw_d play_state matches ..-1 run scoreboard players operation #sw_d play_state *= -1 const
execute if score #sw_d play_state matches 1601.. run scoreboard players set #sw_d play_state 1600

# ---- 2. 注入起点 + 宏调用采样 ----
# 交互实体 Pos = 中心 − size/2 ⇒ 先抬 size/2 到玻璃中心，再沿朝向后退 d 格 → 段起点 P(T-2)
# 精度：26.x store result storage double/int 会截断小数 ⇒ 走 entity data.<字段> double（不截断）→ data modify set from
scoreboard players set #sw_i play_state 0
execute store result entity @s data.sweep_hs double 0.01 run scoreboard players get @s note_half_size
execute store result entity @s data.sweep_d double 0.01 run scoreboard players get #sw_d play_state
data modify storage rhythm_axe:sweep hs set from entity @s data.sweep_hs
data modify storage rhythm_axe:sweep d set from entity @s data.sweep_d
function rhythm_axe:play/active_note/glass_sweep_entry with storage rhythm_axe:sweep
