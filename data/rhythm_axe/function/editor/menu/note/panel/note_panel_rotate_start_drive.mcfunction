# 旋转：逐个选中音符按 #flip_axis 绕判定位置（原点）旋转 start_pos（普通函数驱动器）
# 前置：#flip_i / #flip_total、#rot_cos/#rot_sin（×10000）、prop.cursor、prop.flip_cursor
execute if score #flip_i editor < #flip_total editor run execute store result storage rhythm_axe:prop idx int 1 run scoreboard players get #flip_i editor
execute if score #flip_i editor < #flip_total editor run function rhythm_axe:editor/menu/note/panel/note_panel_rotate_start_leaf with storage rhythm_axe:prop
execute if score #flip_i editor < #flip_total editor run data remove storage rhythm_axe:prop idx
scoreboard players add #flip_i editor 1
execute if score #flip_i editor < #flip_total editor run function rhythm_axe:editor/menu/note/panel/note_panel_rotate_start_drive
