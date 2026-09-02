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
execute at @s positioned ~-1 ~-1 ~-1 if entity @a[dx=0,dy=0,dz=0] positioned ~1 ~1 ~1 if entity @a[dx=0,dy=0,dz=0] run function rhythm_axe:play/judgement_feedback/damage
# 游标+1，未到 N 继续（i=N 是终点 B，含在内）
scoreboard players add #i play_state 1
execute if score #i play_state <= #N play_state run function rhythm_axe:play/active_note/glass_sweep_step
