# 叉号每刻驱动器：实体寿命 + 生成节奏（每 2 刻一个、共 128 刻）+ 收尾
# 实体寿命：生成后隔 1 刻再开始缩（同刻插值无起点），第 8 刻删除（4 刻缩完就已不可见）
scoreboard players add @e[tag=cross] cross_time 1
execute as @e[tag=cross] if score @s cross_time matches 2 run function rhythm_axe:maps/goodworld/laser/cross_animate
execute as @e[tag=cross] if score @s cross_time matches 8 run kill @s

# 生成节奏：#cr_shot 每刻 +1，%2==1 且 ≤128 时生成一个（t=0,2,4,…,126 共 64 个）
scoreboard players add #cr_shot cross_time 1
scoreboard players operation #cr_mod cross_time = #cr_shot cross_time
scoreboard players set #cr_2 cross_time 2
scoreboard players operation #cr_mod cross_time %= #cr_2 cross_time
execute if score #cr_mod cross_time matches 1 if score #cr_shot cross_time matches ..128 run function rhythm_axe:maps/goodworld/laser/cross_fire

# 循环控制 + 收尾（跑到第 140 刻收工，清掉冗余计分板；末个在第 134 刻自然消亡）
execute unless score #cr_shot cross_time matches 140.. run schedule function rhythm_axe:maps/goodworld/laser/cross_main 1t
execute if score #cr_shot cross_time matches 140 run scoreboard objectives remove cross_time
