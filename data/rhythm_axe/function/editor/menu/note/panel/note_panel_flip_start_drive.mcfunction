# 同时翻转起始位置：逐个选中音符 start_pos 三轴取反（普通函数驱动器，防宏递归幽灵）
# 前置：#flip_i / #flip_total、prop.cursor
execute if score #flip_i editor < #flip_total editor run execute store result storage rhythm_axe:prop idx int 1 run scoreboard players get #flip_i editor
execute if score #flip_i editor < #flip_total editor run function rhythm_axe:editor/menu/note/panel/note_panel_flip_start_leaf with storage rhythm_axe:prop
execute if score #flip_i editor < #flip_total editor run data remove storage rhythm_axe:prop idx
scoreboard players add #flip_i editor 1
execute if score #flip_i editor < #flip_total editor run function rhythm_axe:editor/menu/note/panel/note_panel_flip_start_drive
