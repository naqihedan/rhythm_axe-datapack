#arg:idx
# 批量应用叶子（宏函数，不递归）：读 batch_ids[$(idx)] → find_by_id → 调用 batch_apply_one 应用增量
# ★ 顺序游标：find_by_id 从 batch_cursor（上次命中+1）开始，避免每个 id 都全扫 notes（O(n²) 超限）
#   未命中兜底从 0 全扫（batch_ids 来自 selection，按 notes 顺序递增时 O(n)；乱序兜底保证不漏）
$execute store result storage rhythm_axe:prop note_id int 1 run data get storage rhythm_axe:maps.editor editing.batch_ids[$(idx)]
execute store result storage rhythm_axe:prop index int 1 run data get storage rhythm_axe:prop batch_cursor
data remove storage rhythm_axe:prop found_index
function rhythm_axe:editor/util/find_by_id
# 兜底：游标起未命中（乱序）→ 从 0 全扫再找一次
execute unless data storage rhythm_axe:prop found_index run data modify storage rhythm_axe:prop index set value 0
execute unless data storage rhythm_axe:prop found_index run function rhythm_axe:editor/util/find_by_id
execute if data storage rhythm_axe:prop found_index run data modify storage rhythm_axe:prop index set from storage rhythm_axe:prop found_index
execute if data storage rhythm_axe:prop found_index run function rhythm_axe:editor/menu/note/batch/batch_apply_one with storage rhythm_axe:prop
# 命中后把游标推进到 found_index+1，下一个 id 从这里继续找
execute if data storage rhythm_axe:prop found_index run execute store result score #tmp editor run data get storage rhythm_axe:prop found_index
execute if data storage rhythm_axe:prop found_index run scoreboard players add #tmp editor 1
execute if data storage rhythm_axe:prop found_index run execute store result storage rhythm_axe:prop batch_cursor int 1 run scoreboard players get #tmp editor
data remove storage rhythm_axe:prop note_id
data remove storage rhythm_axe:prop found_index
