# 元件驱动器（每刻自调度）：年龄推进 + 关键帧 + 每刻生成一个（共 64 次）+ 收尾
#   ★ 关键帧按「实体自身年龄」触发 ⇒ 多个元件同时存活也各播各的，互不干扰
#   年龄轴：4→y段1 / 8→y段2 / 12→y段3 / 16→y段4+scale→0 / 20→删除
scoreboard players add @e[tag=good2384] g2384_t 1
execute as @e[tag=good2384,scores={g2384_t=4}] run function rhythm_axe:maps/goodworld/good2384_2
execute as @e[tag=good2384,scores={g2384_t=8}] run function rhythm_axe:maps/goodworld/good2384_3
execute as @e[tag=good2384,scores={g2384_t=12}] run function rhythm_axe:maps/goodworld/good2384_4
execute as @e[tag=good2384,scores={g2384_t=16}] run function rhythm_axe:maps/goodworld/good2384_5
execute as @e[tag=good2384,scores={g2384_t=20..}] run kill @s

# 每刻生成一个（剩余次数 >0 时）
execute if score #g2384_left g2384_t matches 1.. run function rhythm_axe:maps/goodworld/good2384_emit

# 继续条件：还有次数，或场上还有元件
scoreboard players set #g2384_go g2384_t 0
execute if score #g2384_left g2384_t matches 1.. run scoreboard players set #g2384_go g2384_t 1
execute if entity @e[tag=good2384] run scoreboard players set #g2384_go g2384_t 1
execute if score #g2384_go g2384_t matches 1 run schedule function rhythm_axe:maps/goodworld/good2384_6 1t
execute if score #g2384_go g2384_t matches 0 run function rhythm_axe:maps/goodworld/good2384_clear
