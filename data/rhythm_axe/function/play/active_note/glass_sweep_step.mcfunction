# 玻璃扫掠单采样点（@s = 玻璃中心 marker；glass_sweep 初始化后递归）
# 采样点 P = A + d×i/N（×100 整数运算，注意先乘后除保精度）
# 把 marker 移到采样点 → at @s 刷新位置 → 对角区域点检测（命中 → damage）→ i+1 递归
# 对角区域检测 = "中心点在玩家判定箱内"（2×2×2 取对角两 1×1×1，只在中心点相交）

# 采样点坐标（×100）：sx = ax + dx*i/N
scoreboard players operation #sx play_state = #dx play_state
scoreboard players operation #sx play_state *= #i play_state
scoreboard players operation #sx play_state /= #N play_state
scoreboard players operation #sx play_state += #ax play_state
scoreboard players operation #sy play_state = #dy play_state
scoreboard players operation #sy play_state *= #i play_state
scoreboard players operation #sy play_state /= #N play_state
scoreboard players operation #sy play_state += #ay play_state
scoreboard players operation #sz play_state = #dz play_state
scoreboard players operation #sz play_state *= #i play_state
scoreboard players operation #sz play_state /= #N play_state
scoreboard players operation #sz play_state += #az play_state
# marker 移到采样点（×100 → double 0.01）
execute store result entity @s Pos[0] double 0.01 run scoreboard players get #sx play_state
execute store result entity @s Pos[1] double 0.01 run scoreboard players get #sy play_state
execute store result entity @s Pos[2] double 0.01 run scoreboard players get #sz play_state
# at @s 刷新执行位置（移动 Pos 后上下文位置不自动更新）→ 对角区域点检测
# ★ 判定体 = 玻璃中心周围 0.5³ 方块（与「玩家判定箱各轴外扩 0.25」等价）：两个 dx=0 检测点相距 0.5。
#   引擎里 dx=0 实际是「从该点起 1 格宽」的判定体，两点取交集后有效范围 = 玩家箱 ±(两点间距/2)：
#   旧写法 −1/+1（间距 1）→ ±0.25 格（用户口中的"方块中心一点"）；新写法 −0.75/+0.5（间距 0.5）→ ±0.50 格。实测确认。
execute at @s positioned ~-0.75 ~-0.75 ~-0.75 if entity @a[team=player,dx=0,dy=0,dz=0] positioned ~0.5 ~0.5 ~0.5 if entity @a[team=player,dx=0,dy=0,dz=0] run function rhythm_axe:play/judgement_feedback/damage
# 游标+1，未到 N 继续（i=N 是终点 B，含在内）
scoreboard players add #i play_state 1
execute if score #i play_state <= #N play_state run function rhythm_axe:play/active_note/glass_sweep_step
