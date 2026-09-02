#arg:cursor,note_index
# 取出当前 id，复用按 id 查找链定位该音符（未找到则静默跳过）
$execute store result score #target_id editor run data get storage rhythm_axe:prop note_ids[$(note_index)]
execute store result storage rhythm_axe:prop note_id int 1 run scoreboard players get #target_id editor
data modify storage rhythm_axe:prop index set value 0
data remove storage rhythm_axe:prop found_index
function rhythm_axe:editor/util/find_by_id
execute if data storage rhythm_axe:prop found_index run function rhythm_axe:editor/note/copy/copy_one_collect with storage rhythm_axe:prop
function rhythm_axe:editor/note/copy/copy_one_advance with storage rhythm_axe:prop
