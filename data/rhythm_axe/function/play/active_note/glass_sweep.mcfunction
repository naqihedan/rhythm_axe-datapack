# 玻璃扫掠碰撞检测（CCD，@s = 玻璃中心 marker；每 tick 由 active_note 调用）
# 解决"玻璃移动太快时中心点跳过玩家判定箱"的隧穿问题：
#   玻璃移动是离散的（每 tick 一步），若每刻位移 > 玩家判定箱宽（0.6 格），
#   两个采样时刻的中心点可能都在玩家箱外、但中间路径穿过了玩家箱 → 视觉撞上却无判定。
#   解决：沿"上一刻中心 → 当前中心"线段按 1.0 格步长采样多个点，每点是「玻璃中心 0.5³ 方块」判定体，
#   命中任一采样点即 damage（判定体 xz 覆盖宽 1.1 > 步长 1.0 → 路径必被覆盖）。
# 位置来源（move.mcfunction 写入）：
#   marker Pos = 上一刻视觉中心（×100 读取）；marker note_prev_* = 当前视觉中心
# 注意：采样点坐标用 marker 实体 Pos 承载（execute positioned 不能用动态计分板坐标，
#   store result entity Pos 是唯一动态小数写法；检测后 marker 停在当前中心 = 下一 tick move 会重写）

# 读上一刻中心 A（marker 当前 Pos，×100）
execute store result score #ax play_state run data get entity @s Pos[0] 100
execute store result score #ay play_state run data get entity @s Pos[1] 100
execute store result score #az play_state run data get entity @s Pos[2] 100
# 读当前中心 B（marker note_prev_*，×100；move 已记录）
execute store result score #bx play_state run scoreboard players get @s note_prev_x
execute store result score #by play_state run scoreboard players get @s note_prev_y
execute store result score #bz play_state run scoreboard players get @s note_prev_z
# 位移 d = B - A（×100）
scoreboard players operation #dx play_state = #bx play_state
scoreboard players operation #dx play_state -= #ax play_state
scoreboard players operation #dy play_state = #by play_state
scoreboard players operation #dy play_state -= #ay play_state
scoreboard players operation #dz play_state = #bz play_state
scoreboard players operation #dz play_state -= #az play_state
# 距离²（×10000）→ sqrt → 距离（×100，#sqrt_out）
scoreboard players operation #sqrt_sq display_calc = #dx play_state
scoreboard players operation #sqrt_sq display_calc *= #dx play_state
scoreboard players operation #stmp display_calc = #dy play_state
scoreboard players operation #stmp display_calc *= #dy play_state
scoreboard players operation #sqrt_sq display_calc += #stmp display_calc
scoreboard players operation #stmp display_calc = #dz play_state
scoreboard players operation #stmp display_calc *= #dz play_state
scoreboard players operation #sqrt_sq display_calc += #stmp display_calc
# 采样步数 N = ceil(距离/1.0)（步长 1.0 格；2026-09-13 由 0.5 加倍 → 采样数减半）。★ 性能优化（2026-09-04）：
#   不做 sqrt（108 命令/玻璃/刻，玻璃为主谱面的大头），直接按距离²（#sqrt_sq，×10000）查阈值：
#   N = ceil(d/1.0) ⟺ d² > (N-1)² → 阈值 (N-1)²×10000。N 上限 16（15 格/刻），实际位移远低于此。
#   ★ 步长加倍不会隧穿：单个采样点的判定体 = 「玻璃中心 0.5³ 方块 ∩ 玩家判定箱」
#   = 玩家判定箱各轴外扩 0.25（XZ 宽 0.6+0.5=1.1 > 步长 1.0）→ 相邻采样的覆盖区相邻重叠。
scoreboard players set #N play_state 1
execute if score #sqrt_sq display_calc > 10000 const run scoreboard players set #N play_state 2
execute if score #sqrt_sq display_calc > 40000 const run scoreboard players set #N play_state 3
execute if score #sqrt_sq display_calc > 90000 const run scoreboard players set #N play_state 4
execute if score #sqrt_sq display_calc > 160000 const run scoreboard players set #N play_state 5
execute if score #sqrt_sq display_calc > 250000 const run scoreboard players set #N play_state 6
execute if score #sqrt_sq display_calc > 360000 const run scoreboard players set #N play_state 7
execute if score #sqrt_sq display_calc > 490000 const run scoreboard players set #N play_state 8
execute if score #sqrt_sq display_calc > 640000 const run scoreboard players set #N play_state 9
execute if score #sqrt_sq display_calc > 810000 const run scoreboard players set #N play_state 10
execute if score #sqrt_sq display_calc > 1000000 const run scoreboard players set #N play_state 11
execute if score #sqrt_sq display_calc > 1210000 const run scoreboard players set #N play_state 12
execute if score #sqrt_sq display_calc > 1440000 const run scoreboard players set #N play_state 13
execute if score #sqrt_sq display_calc > 1690000 const run scoreboard players set #N play_state 14
execute if score #sqrt_sq display_calc > 1960000 const run scoreboard players set #N play_state 15
execute if score #sqrt_sq display_calc > 2250000 const run scoreboard players set #N play_state 16
# 采样游标 i 从 0 开始（含 A 与 B 两端）
scoreboard players set #i play_state 0
function rhythm_axe:play/active_note/glass_sweep_step
