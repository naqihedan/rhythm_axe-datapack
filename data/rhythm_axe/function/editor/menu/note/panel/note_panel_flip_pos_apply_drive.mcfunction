# 判定位置轴镜像：逐个选中音符原位改 position[flip_axis]（普通函数驱动器，防宏递归幽灵）
# 前置：#flip_i / #flip_total、#flip_min/#flip_max、prop.cursor、prop.flip_axis
execute if score #flip_i editor < #flip_total editor run execute store result storage rhythm_axe:prop idx int 1 run scoreboard players get #flip_i editor
execute if score #flip_i editor < #flip_total editor run function rhythm_axe:editor/menu/note/panel/note_panel_flip_pos_apply_leaf with storage rhythm_axe:prop
execute if score #flip_i editor < #flip_total editor run data remove storage rhythm_axe:prop idx
scoreboard players add #flip_i editor 1
execute if score #flip_i editor < #flip_total editor run function rhythm_axe:editor/menu/note/panel/note_panel_flip_pos_apply_drive
