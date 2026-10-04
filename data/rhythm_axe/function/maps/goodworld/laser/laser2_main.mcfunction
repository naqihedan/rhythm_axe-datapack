# 激光2 每刻驱动器：实体寿命 + 波次（每 8 刻一波、共 12 波 = 96 刻）+ 收尾
# 实体寿命：出生后隔 1 刻再动画（同刻插值无起点），第 8 刻删除（正好是 6 刻插值走完那一刻）
scoreboard players add @e[tag=laser2] laser2_time 1
execute as @e[tag=laser2] if score @s laser2_time matches 2 run function rhythm_axe:maps/goodworld/laser/laser2_animate
execute as @e[tag=laser2] if score @s laser2_time matches 8 run kill @s

# 波次计时：#l2_shot 每刻 +1，%8==1 且 ≤89 时发一波（t=0,8,16,…,88 共 12 波）
scoreboard players add #l2_shot laser2_time 1
scoreboard players operation #l2_mod laser2_time = #l2_shot laser2_time
scoreboard players set #l2_8 laser2_time 8
scoreboard players operation #l2_mod laser2_time %= #l2_8 laser2_time
execute if score #l2_mod laser2_time matches 1 if score #l2_shot laser2_time matches ..89 run function rhythm_axe:maps/goodworld/laser/laser2_fire

# 循环控制 + 收尾（跑到第 104 刻收工，清掉冗余计分板；末束在第 96 刻自然消亡）
execute unless score #l2_shot laser2_time matches 104.. run schedule function rhythm_axe:maps/goodworld/laser/laser2_main 1t
execute if score #l2_shot laser2_time matches 104 run scoreboard objectives remove laser2_time
