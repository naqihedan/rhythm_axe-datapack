#arg:cursor,index
# 时间点列表行遍历：█ 颜色判定 + 每行 4 个按钮值（编辑 201+、复制 211+、粘贴 221+、删除 231+）
# 颜色：index=0 红线；否则与前一时间点比较 bpm/tps → prop.is_red
data remove storage rhythm_axe:prop is_red
execute store result score #temp_playhead editor run data get storage rhythm_axe:prop index
execute if score #temp_playhead editor matches ..0 run data modify storage rhythm_axe:prop is_red set value 1b
execute if score #temp_playhead editor matches 1.. run scoreboard players remove #temp_playhead editor 1
execute if score #temp_playhead editor matches 0.. run execute store result storage rhythm_axe:prop prev int 1 run scoreboard players get #temp_playhead editor
execute if score #temp_playhead editor matches 0.. run function rhythm_axe:editor/menu/timing/list/timing_list_line_color with storage rhythm_axe:prop
# 按钮点击值：规范v2 值 = (1000+行序)×100 + 列动作码(编辑3/复制5/粘贴6/删除7)，行序 0 基无上限
execute store result score #temp editor run data get storage rhythm_axe:prop index
scoreboard players add #temp editor 1000
scoreboard players operation #temp editor *= 100 const
# 编辑(3)
scoreboard players operation #edit_val editor = #temp editor
scoreboard players add #edit_val editor 3
execute store result storage rhythm_axe:prop edit_val int 1 run scoreboard players get #edit_val editor
# 复制(5)
scoreboard players operation #copy_val editor = #temp editor
scoreboard players add #copy_val editor 5
execute store result storage rhythm_axe:prop copy_val int 1 run scoreboard players get #copy_val editor
# 粘贴(6)
scoreboard players operation #paste_val editor = #temp editor
scoreboard players add #paste_val editor 6
execute store result storage rhythm_axe:prop paste_val int 1 run scoreboard players get #paste_val editor
# 删除(7)
scoreboard players operation #delete_val editor = #temp editor
scoreboard players add #delete_val editor 7
execute store result storage rhythm_axe:prop delete_val int 1 run scoreboard players get #delete_val editor
# 输出行并递归
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].timing_points[$(index)] run function rhythm_axe:editor/menu/timing/list/timing_list_line with storage rhythm_axe:prop
$execute unless data storage rhythm_axe:maps.editor history[$(cursor)].timing_points[$(index)] run return 0
execute store result score #index editor run data get storage rhythm_axe:prop index
scoreboard players add #index editor 1
execute store result storage rhythm_axe:prop index int 1 run scoreboard players get #index editor
function rhythm_axe:editor/menu/timing/list/timing_list_row with storage rhythm_axe:prop
