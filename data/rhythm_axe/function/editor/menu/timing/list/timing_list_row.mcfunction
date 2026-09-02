#arg:cursor,index
# 时间点列表行遍历：█ 颜色判定 + 每行 4 个按钮值（编辑 201+、复制 211+、粘贴 221+、删除 231+）
# 颜色：index=0 红线；否则与前一时间点比较 bpm/tps → prop.is_red
data remove storage rhythm_axe:prop is_red
execute store result score #temp_playhead editor run data get storage rhythm_axe:prop index
execute if score #temp_playhead editor matches ..0 run data modify storage rhythm_axe:prop is_red set value 1b
execute if score #temp_playhead editor matches 1.. run scoreboard players remove #temp_playhead editor 1
execute if score #temp_playhead editor matches 0.. run execute store result storage rhythm_axe:prop prev int 1 run scoreboard players get #temp_playhead editor
execute if score #temp_playhead editor matches 0.. run function rhythm_axe:editor/menu/timing/list/timing_list_line_color with storage rhythm_axe:prop
# 按钮点击值
execute store result score #temp editor run data get storage rhythm_axe:prop index
scoreboard players add #temp editor 201
execute store result storage rhythm_axe:prop edit_val int 1 run scoreboard players get #temp editor
scoreboard players add #temp editor 10
execute store result storage rhythm_axe:prop copy_val int 1 run scoreboard players get #temp editor
scoreboard players add #temp editor 10
execute store result storage rhythm_axe:prop paste_val int 1 run scoreboard players get #temp editor
scoreboard players add #temp editor 10
execute store result storage rhythm_axe:prop delete_val int 1 run scoreboard players get #temp editor
# 输出行并递归
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].timing_points[$(index)] run function rhythm_axe:editor/menu/timing/list/timing_list_line with storage rhythm_axe:prop
$execute unless data storage rhythm_axe:maps.editor history[$(cursor)].timing_points[$(index)] run return 0
execute store result score #index editor run data get storage rhythm_axe:prop index
scoreboard players add #index editor 1
execute store result storage rhythm_axe:prop index int 1 run scoreboard players get #index editor
function rhythm_axe:editor/menu/timing/list/timing_list_row with storage rhythm_axe:prop
