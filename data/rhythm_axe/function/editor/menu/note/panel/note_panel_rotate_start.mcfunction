# 旋转核心（无 begin/commit）：按 #flip_axis 绕判定位置（原点）旋转选中音符 start_pos
# 前置：#flip_axis、#rot_cos/#rot_sin（×10000）、selection、prop.cursor
data modify storage rhythm_axe:prop flip_cursor set value 0
scoreboard players set #flip_i editor 0
execute store result score #flip_total editor run data get storage rhythm_axe:maps.editor selection
function rhythm_axe:editor/menu/note/panel/note_panel_rotate_start_drive
data remove storage rhythm_axe:prop flip_cursor
