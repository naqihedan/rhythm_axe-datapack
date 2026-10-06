# 引导线染色：@s = 引导线展示实体（item_display），按 @s note_guide_color 换成同色的染色玻璃
#   ★ 2026-10-07 用户定：引导线颜色 = **生成这条线的音符 A** 的 color（面板 11 的「颜色」行）。
#     · 编辑器：editor/visual/guide_spawn_ 从 prop.color（= A 的颜色）写入
#     · 游玩：  play/note/guide/spawn 从 A 端展示实体的 note_color 写入
#   · color 0 / 缺字段 = 未设置 → **不改动**，保持生成时的默认青色（观感与旧版一致）
#   · 颜色表与音符外观同源（编辑器 fill_disp / 游玩 summon 的混凝土·染色玻璃 16 色）
#   非宏函数（无 $ 行）：两种模式都能直接调，零宏展开开销
execute if score @s note_guide_color matches 1 run data modify entity @s item.id set value "minecraft:white_stained_glass"
execute if score @s note_guide_color matches 2 run data modify entity @s item.id set value "minecraft:gray_stained_glass"
execute if score @s note_guide_color matches 3 run data modify entity @s item.id set value "minecraft:light_gray_stained_glass"
execute if score @s note_guide_color matches 4 run data modify entity @s item.id set value "minecraft:black_stained_glass"
execute if score @s note_guide_color matches 5 run data modify entity @s item.id set value "minecraft:brown_stained_glass"
execute if score @s note_guide_color matches 6 run data modify entity @s item.id set value "minecraft:red_stained_glass"
execute if score @s note_guide_color matches 7 run data modify entity @s item.id set value "minecraft:orange_stained_glass"
execute if score @s note_guide_color matches 8 run data modify entity @s item.id set value "minecraft:yellow_stained_glass"
execute if score @s note_guide_color matches 9 run data modify entity @s item.id set value "minecraft:lime_stained_glass"
execute if score @s note_guide_color matches 10 run data modify entity @s item.id set value "minecraft:green_stained_glass"
execute if score @s note_guide_color matches 11 run data modify entity @s item.id set value "minecraft:cyan_stained_glass"
execute if score @s note_guide_color matches 12 run data modify entity @s item.id set value "minecraft:light_blue_stained_glass"
execute if score @s note_guide_color matches 13 run data modify entity @s item.id set value "minecraft:blue_stained_glass"
execute if score @s note_guide_color matches 14 run data modify entity @s item.id set value "minecraft:purple_stained_glass"
execute if score @s note_guide_color matches 15 run data modify entity @s item.id set value "minecraft:magenta_stained_glass"
execute if score @s note_guide_color matches 16 run data modify entity @s item.id set value "minecraft:pink_stained_glass"
