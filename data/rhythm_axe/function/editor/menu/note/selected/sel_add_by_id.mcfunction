# 按音符 id 找其在 notes 的下标，再按住 idx 插入 selection（单选/复选框用；@s = 玩家）
# 前置：prop.nid（音符 id）；内部 find_by_id 一次（O(n)，单选 OK）
data modify storage rhythm_axe:prop cursor set from storage rhythm_axe:maps.editor history_cursor
data modify storage rhythm_axe:prop index set value 0
data modify storage rhythm_axe:prop note_id set from storage rhythm_axe:prop nid
data remove storage rhythm_axe:prop found_index
function rhythm_axe:editor/util/find_by_id
execute if data storage rhythm_axe:prop found_index run execute store result storage rhythm_axe:prop sel_idx int 1 run data get storage rhythm_axe:prop found_index
execute if data storage rhythm_axe:prop found_index run function rhythm_axe:editor/menu/note/selected/sel_add
data remove storage rhythm_axe:prop cursor
data remove storage rhythm_axe:prop index
data remove storage rhythm_axe:prop note_id
data remove storage rhythm_axe:prop found_index
data remove storage rhythm_axe:prop sel_idx
