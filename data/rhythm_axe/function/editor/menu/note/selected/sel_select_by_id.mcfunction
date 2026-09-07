# 按 id 选中一个音符：find 其工作副本下标 → 加 selected:1b → 重建 selection（@s = 玩家）
# 前置：prop.nid（音符 id）
data modify storage rhythm_axe:prop cursor set from storage rhythm_axe:maps.editor history_cursor
data modify storage rhythm_axe:prop index set value 0
data modify storage rhythm_axe:prop note_id set from storage rhythm_axe:prop nid
data remove storage rhythm_axe:prop found_index
function rhythm_axe:editor/util/find_by_id
execute if data storage rhythm_axe:prop found_index run execute store result storage rhythm_axe:prop idx int 1 run data get storage rhythm_axe:prop found_index
execute if data storage rhythm_axe:prop found_index run function rhythm_axe:editor/menu/note/selected/sel_select_one with storage rhythm_axe:prop
function rhythm_axe:editor/menu/note/selected/sel_rebuild
data remove storage rhythm_axe:prop cursor
data remove storage rhythm_axe:prop index
data remove storage rhythm_axe:prop note_id
data remove storage rhythm_axe:prop found_index
data remove storage rhythm_axe:prop idx
