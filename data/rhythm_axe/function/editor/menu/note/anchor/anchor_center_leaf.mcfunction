#arg:idx
# 锚点中心扫描叶子（宏函数，不递归）：读 selection[$(idx)] → find_by_id（顺序游标 anc_cursor；未命中兜底从 0 全扫）
#   selection 由 sel_rebuild 保证按 notes 顺序递增 → 顺序游标 O(n)；兜底保证乱序也不漏
$execute store result storage rhythm_axe:prop note_id int 1 run data get storage rhythm_axe:maps.editor selection[$(idx)]
execute store result storage rhythm_axe:prop index int 1 run data get storage rhythm_axe:prop anc_cursor
data remove storage rhythm_axe:prop found_index
function rhythm_axe:editor/util/find_by_id
# 兜底：游标起未命中（乱序）→ 从 0 全扫再找一次
execute unless data storage rhythm_axe:prop found_index run data modify storage rhythm_axe:prop index set value 0
execute unless data storage rhythm_axe:prop found_index run function rhythm_axe:editor/util/find_by_id
execute if data storage rhythm_axe:prop found_index run data modify storage rhythm_axe:prop index set from storage rhythm_axe:prop found_index
execute if data storage rhythm_axe:prop found_index run function rhythm_axe:editor/menu/note/anchor/anchor_center_one with storage rhythm_axe:prop
# 命中后推进顺序游标到 found_index+1
execute if data storage rhythm_axe:prop found_index run execute store result score #anc_tmp editor run data get storage rhythm_axe:prop found_index
execute if data storage rhythm_axe:prop found_index run scoreboard players add #anc_tmp editor 1
execute if data storage rhythm_axe:prop found_index run execute store result storage rhythm_axe:prop anc_cursor int 1 run scoreboard players get #anc_tmp editor
data remove storage rhythm_axe:prop note_id
data remove storage rhythm_axe:prop found_index
