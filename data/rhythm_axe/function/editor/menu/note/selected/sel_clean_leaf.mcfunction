#arg:slc_idx
# 处理 selection[$(slc_idx)]：若 find_by_id 能找到该音符则保留（append 到 prop.slc_out），否则跳过
# ★ 顺序游标：find_by_id 从 clean_cursor（上次命中+1）开始，避免每个 id 都全扫 notes（O(n²) 超限）
$execute store result storage rhythm_axe:prop note_id int 1 run data get storage rhythm_axe:maps.editor selection[$(slc_idx)]
data modify storage rhythm_axe:prop cursor set from storage rhythm_axe:maps.editor history_cursor
execute store result storage rhythm_axe:prop index int 1 run data get storage rhythm_axe:prop clean_cursor
data remove storage rhythm_axe:prop found_index
function rhythm_axe:editor/util/find_by_id
$execute if data storage rhythm_axe:prop found_index run data modify storage rhythm_axe:prop slc_out append from storage rhythm_axe:maps.editor selection[$(slc_idx)]
# 命中后把游标推进到 found_index+1，下一个 id 从这里继续找
execute if data storage rhythm_axe:prop found_index run execute store result score #tmp editor run data get storage rhythm_axe:prop found_index
execute if data storage rhythm_axe:prop found_index run scoreboard players add #tmp editor 1
execute if data storage rhythm_axe:prop found_index run execute store result storage rhythm_axe:prop clean_cursor int 1 run scoreboard players get #tmp editor
# 清理本叶子用到的临时 prop
data remove storage rhythm_axe:prop found_index
data remove storage rhythm_axe:prop note_id
data remove storage rhythm_axe:prop index
