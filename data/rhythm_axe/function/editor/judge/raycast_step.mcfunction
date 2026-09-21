# 射线步进单步（@s = 玩家，执行位置 = 当前采样点，朝向 = 玩家朝向；递归直到 #ray_max 步）
# 采样点附近 1 格内的编辑器音符展示实体（Pos = 判定位置）→ 打 editor_n_looked_perfect（保护进入用）
# ★ 直接打在展示实体上（判定主体就是它），省掉游玩那层"展示实体 → 配对交互实体"的配对查找
execute as @e[type=item_display,tag=editor_note,distance=..1.0] run tag @s add editor_n_looked_perfect
# 前进 0.5 格到下一采样点
execute positioned ^ ^ ^0.5 run scoreboard players add #ray_d editor 1
# 未到最大步数 → 在下一采样点继续
execute if score #ray_d editor < #ray_max editor positioned ^ ^ ^0.5 run function rhythm_axe:editor/judge/raycast_step
