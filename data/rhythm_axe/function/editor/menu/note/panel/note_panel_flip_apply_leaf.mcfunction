#arg:idx
# 时间轴翻转应用叶子（宏函数，不递归）：读 batch_ids[$(idx)] → find_by_id（全扫，因前一个音符 remove/reinsert 已改变数组）
#   → 命中后调 flip_apply_one（读完整音符→改 time→移除→重插）
$execute store result storage rhythm_axe:prop note_id int 1 run data get storage rhythm_axe:maps.editor selection[$(idx)]
data modify storage rhythm_axe:prop index set value 0
data remove storage rhythm_axe:prop found_index
function rhythm_axe:editor/util/find_by_id
execute if data storage rhythm_axe:prop found_index run data modify storage rhythm_axe:prop index set from storage rhythm_axe:prop found_index
execute if data storage rhythm_axe:prop found_index run function rhythm_axe:editor/menu/note/panel/note_panel_flip_apply_one with storage rhythm_axe:prop
data remove storage rhythm_axe:prop note_id
data remove storage rhythm_axe:prop found_index
