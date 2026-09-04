#arg:cursor,note_index
# 取出当前 id，按 id 查找定位该音符（未找到则静默跳过）
# ★ 顺序游标：下标从 copy_cursor（上次命中+1）开始，非 0，避免 O(n²) 全扫
$execute store result score #target_id editor run data get storage rhythm_axe:prop note_ids[$(note_index)]
execute store result storage rhythm_axe:prop note_id int 1 run scoreboard players get #target_id editor
# 从上次命中的下一位置继续（未命中/首次则 0）
execute store result storage rhythm_axe:prop index int 1 run data get storage rhythm_axe:prop copy_cursor
data remove storage rhythm_axe:prop found_index
function rhythm_axe:editor/util/find_by_id
execute if data storage rhythm_axe:prop found_index run function rhythm_axe:editor/note/copy/copy_one_collect with storage rhythm_axe:prop
# 命中后把游标推进到 found_index+1，下一个 id 从这里继续找
execute if data storage rhythm_axe:prop found_index run execute store result score #tmp editor run data get storage rhythm_axe:prop found_index
execute if data storage rhythm_axe:prop found_index run scoreboard players add #tmp editor 1
execute if data storage rhythm_axe:prop found_index run execute store result storage rhythm_axe:prop copy_cursor int 1 run scoreboard players get #tmp editor
function rhythm_axe:editor/note/copy/copy_one_advance with storage rhythm_axe:prop
