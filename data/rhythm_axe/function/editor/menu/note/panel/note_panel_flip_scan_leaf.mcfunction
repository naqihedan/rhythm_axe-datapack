#arg:idx
# 时间轴翻转扫描叶子（宏函数，不递归）：读 batch_ids[$(idx)] → find_by_id（顺序游标 flip_cursor，此步不改数组）→ 读 time 更新 min/max
$execute store result storage rhythm_axe:prop note_id int 1 run data get storage rhythm_axe:maps.editor selection[$(idx)]
execute store result storage rhythm_axe:prop index int 1 run data get storage rhythm_axe:prop flip_cursor
data remove storage rhythm_axe:prop found_index
function rhythm_axe:editor/util/find_by_id
execute if data storage rhythm_axe:prop found_index run data modify storage rhythm_axe:prop index set from storage rhythm_axe:prop found_index
execute if data storage rhythm_axe:prop found_index run function rhythm_axe:editor/menu/note/panel/note_panel_flip_scan_one with storage rhythm_axe:prop
# 命中后把顺序游标推进到 found_index+1，下一个 id 从这里继续找
execute if data storage rhythm_axe:prop found_index run execute store result score #tmp editor run data get storage rhythm_axe:prop found_index
execute if data storage rhythm_axe:prop found_index run scoreboard players add #tmp editor 1
execute if data storage rhythm_axe:prop found_index run execute store result storage rhythm_axe:prop flip_cursor int 1 run scoreboard players get #tmp editor
data remove storage rhythm_axe:prop note_id
data remove storage rhythm_axe:prop found_index
