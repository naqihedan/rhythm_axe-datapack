#arg:slc_idx
# 处理 selection[$(slc_idx)]：若 find_by_id 能找到该音符则保留（append 到 prop.slc_out），否则跳过
$execute store result storage rhythm_axe:prop note_id int 1 run data get storage rhythm_axe:maps.editor selection[$(slc_idx)]
data modify storage rhythm_axe:prop cursor set from storage rhythm_axe:maps.editor history_cursor
data modify storage rhythm_axe:prop index set value 0
data remove storage rhythm_axe:prop found_index
function rhythm_axe:editor/util/find_by_id
$execute if data storage rhythm_axe:prop found_index run data modify storage rhythm_axe:prop slc_out append from storage rhythm_axe:maps.editor selection[$(slc_idx)]
# 清理本叶子用到的临时 prop
data remove storage rhythm_axe:prop found_index
data remove storage rhythm_axe:prop note_id
data remove storage rhythm_axe:prop cursor
data remove storage rhythm_axe:prop index
