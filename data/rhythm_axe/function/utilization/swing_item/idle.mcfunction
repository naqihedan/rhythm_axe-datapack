# 空闲循环：手里拿着小木斧（custom_data rhythm_axe:1）且没在挥砍时，每刻交替写两份外观完全相同的静止位模型
# ★ 目的：让客户端一直认为「物品在变」→ 保持下坠状态 → 与模型里预加的 +COMPENSATION_Y 抵消；
#   同时挥砍开始时不再是从「静止」冷启动，开头几帧也能立刻生效
# 交替标志复用 swing_par（空闲与挥砍/定格互斥，不会同时用）
# 由数据包根 tick 对 @a[tag=!Swing] 调用
scoreboard players add @s swing_par 1
execute if score @s swing_par matches 2.. run scoreboard players set @s swing_par 0
execute store result storage rhythm_axe:prop swing.skin int 1 run data get entity @s weapon.mainhand.components."minecraft:custom_data".axe_skin
execute if score @s swing_par matches 0 run function rhythm_axe:utilization/swing_item/restore_ with storage rhythm_axe:prop swing
execute if score @s swing_par matches 1 run function rhythm_axe:utilization/swing_item/idle_b with storage rhythm_axe:prop swing
