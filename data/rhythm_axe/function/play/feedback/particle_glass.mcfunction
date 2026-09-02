# 染色玻璃破碎粒子（按音符颜色；M2-H 默认组 4 的 damage 情况使用）
# @s = 音符实体（游玩=交互实体；编辑器=展示实体），需有 note_color 分值（1~16 对应 16 色）
# 颜色映射与 play/note/summon 一致（1=white ... 16=pink；无效/缺失回退 6=red）
# 位置：~ ~ ~ 以当前执行位置为基准（= 音符实体位置）
execute if score @s note_color matches 1 run particle minecraft:block{block_state:"minecraft:white_stained_glass"} ~ ~ ~ 0.3 0.3 0.3 0 100 force @a
execute if score @s note_color matches 2 run particle minecraft:block{block_state:"minecraft:gray_stained_glass"} ~ ~ ~ 0.3 0.3 0.3 0 100 force @a
execute if score @s note_color matches 3 run particle minecraft:block{block_state:"minecraft:light_gray_stained_glass"} ~ ~ ~ 0.3 0.3 0.3 0 100 force @a
execute if score @s note_color matches 4 run particle minecraft:block{block_state:"minecraft:black_stained_glass"} ~ ~ ~ 0.3 0.3 0.3 0 100 force @a
execute if score @s note_color matches 5 run particle minecraft:block{block_state:"minecraft:brown_stained_glass"} ~ ~ ~ 0.3 0.3 0.3 0 100 force @a
execute if score @s note_color matches 6 run particle minecraft:block{block_state:"minecraft:red_stained_glass"} ~ ~ ~ 0.3 0.3 0.3 0 100 force @a
execute if score @s note_color matches 7 run particle minecraft:block{block_state:"minecraft:orange_stained_glass"} ~ ~ ~ 0.3 0.3 0.3 0 100 force @a
execute if score @s note_color matches 8 run particle minecraft:block{block_state:"minecraft:yellow_stained_glass"} ~ ~ ~ 0.3 0.3 0.3 0 100 force @a
execute if score @s note_color matches 9 run particle minecraft:block{block_state:"minecraft:lime_stained_glass"} ~ ~ ~ 0.3 0.3 0.3 0 100 force @a
execute if score @s note_color matches 10 run particle minecraft:block{block_state:"minecraft:green_stained_glass"} ~ ~ ~ 0.3 0.3 0.3 0 100 force @a
execute if score @s note_color matches 11 run particle minecraft:block{block_state:"minecraft:cyan_stained_glass"} ~ ~ ~ 0.3 0.3 0.3 0 100 force @a
execute if score @s note_color matches 12 run particle minecraft:block{block_state:"minecraft:light_blue_stained_glass"} ~ ~ ~ 0.3 0.3 0.3 0 100 force @a
execute if score @s note_color matches 13 run particle minecraft:block{block_state:"minecraft:blue_stained_glass"} ~ ~ ~ 0.3 0.3 0.3 0 100 force @a
execute if score @s note_color matches 14 run particle minecraft:block{block_state:"minecraft:purple_stained_glass"} ~ ~ ~ 0.3 0.3 0.3 0 100 force @a
execute if score @s note_color matches 15 run particle minecraft:block{block_state:"minecraft:magenta_stained_glass"} ~ ~ ~ 0.3 0.3 0.3 0 100 force @a
execute if score @s note_color matches 16 run particle minecraft:block{block_state:"minecraft:pink_stained_glass"} ~ ~ ~ 0.3 0.3 0.3 0 100 force @a
execute unless score @s note_color matches 1..16 run particle minecraft:block{block_state:"minecraft:red_stained_glass"} ~ ~ ~ 0.3 0.3 0.3 0 100 force @a
