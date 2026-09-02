# 玻璃扫掠碰撞检测（CCD，@s = 玻璃中心 marker；每 tick 由 active_note 调用）
# 解决"玻璃移动太快时中心点跳过玩家判定箱"的隧穿问题：
#   玻璃移动是离散的（每 tick 一步），若每刻位移 > 玩家判定箱宽（0.6 格），
#   两个采样时刻的中心点可能都在玩家箱外、但中间路径穿过了玩家箱 → 视觉撞上却无判定。
#   解决：沿"上一刻中心 → 当前中心"线段按 0.5 格步长采样多个点，每点做对角区域点检测，
#   命中任一采样点即 damage（步长 < 玩家箱宽 → 路径必被覆盖）。
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
function rhythm_axe:utilization/math/sqrt
# 采样步数 N = ceil(距离×100 / 50)（步长 0.5 格 = 50×100 尺度），至少 1
scoreboard players operation #N play_state = #sqrt_out display_calc
scoreboard players operation #N play_state += 49 const
scoreboard players operation #N play_state /= 50 const
execute if score #N play_state matches ..0 run scoreboard players set #N play_state 1
# 采样游标 i 从 0 开始（含 A 与 B 两端）
scoreboard players set #i play_state 0
function rhythm_axe:play/active_note/glass_sweep_step
