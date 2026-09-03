#arg:idx
# 批量应用叶子（宏函数，不递归）：读 batch_ids[$(idx)] → find_by_id → 调用 batch_apply_one 应用增量
# 沿用 sel_note_list_row 的「宏叶→find_by_id→宏渲染」成熟模式，避免宏递归幽灵
$execute store result storage rhythm_axe:prop note_id int 1 run data get storage rhythm_axe:maps.editor editing.batch_ids[$(idx)]
data modify storage rhythm_axe:prop index set value 0
data remove storage rhythm_axe:prop found_index
function rhythm_axe:editor/util/find_by_id
execute if data storage rhythm_axe:prop found_index run data modify storage rhythm_axe:prop index set from storage rhythm_axe:prop found_index
execute if data storage rhythm_axe:prop found_index run function rhythm_axe:editor/menu/note/batch/batch_apply_one with storage rhythm_axe:prop
data remove storage rhythm_axe:prop note_id
data remove storage rhythm_axe:prop found_index
