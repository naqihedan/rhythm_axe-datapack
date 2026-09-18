# 应用锚点变换：逐个选中音符（普通函数驱动器，防宏递归幽灵）
# 前置：#flip_i（0 起）/ #flip_total（selection 长度）、prop.cursor、prop.flip_cursor、#rc0/1/2、#an_x/y/z、#r11..#r33
execute if score #flip_i editor matches 1000000.. run return 0
execute if score #flip_i editor < #flip_total editor run execute store result storage rhythm_axe:prop idx int 1 run scoreboard players get #flip_i editor
execute if score #flip_i editor < #flip_total editor run function rhythm_axe:editor/menu/note/panel/note_panel_anchor_apply_leaf with storage rhythm_axe:prop
execute if score #flip_i editor < #flip_total editor run data remove storage rhythm_axe:prop idx
scoreboard players add #flip_i editor 1
execute if score #flip_i editor < #flip_total editor run function rhythm_axe:editor/menu/note/panel/note_panel_anchor_apply_drive
