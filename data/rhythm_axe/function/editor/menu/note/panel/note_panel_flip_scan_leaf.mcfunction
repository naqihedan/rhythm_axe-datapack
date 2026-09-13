#arg:idx
# 时间轴翻转扫描叶子（宏函数，不递归）：读 selection[$(idx)] → find_by_id（顺序游标 flip_cursor；未命中兜底从 0 全扫）
#   ★ 2026-09-12 修复：原实现只有顺序游标、没有兜底 → selection 一旦不是"按 notes 下标递增"（乱序）就会静默漏掉音符，
#     min/max 退化成"只剩一个音符" ⇒ 轴跑到 max ⇒ 所有音符被翻到 2·max−old（飞出原区间，世界里看不见）。
#     与 note_panel_flip_pos_scan_leaf / rotate_scan_leaf / flip_start_leaf 的兜底写法保持一致。
$execute store result storage rhythm_axe:prop note_id int 1 run data get storage rhythm_axe:maps.editor selection[$(idx)]
execute store result storage rhythm_axe:prop index int 1 run data get storage rhythm_axe:prop flip_cursor
data remove storage rhythm_axe:prop found_index
function rhythm_axe:editor/util/find_by_id
# 兜底：游标起未命中（乱序）→ 从 0 全扫再找一次
execute unless data storage rhythm_axe:prop found_index run data modify storage rhythm_axe:prop index set value 0
execute unless data storage rhythm_axe:prop found_index run function rhythm_axe:editor/util/find_by_id
execute if data storage rhythm_axe:prop found_index run data modify storage rhythm_axe:prop index set from storage rhythm_axe:prop found_index
execute if data storage rhythm_axe:prop found_index run function rhythm_axe:editor/menu/note/panel/note_panel_flip_scan_one with storage rhythm_axe:prop
# 命中后把顺序游标推进到 found_index+1，下一个 id 从这里继续找
execute if data storage rhythm_axe:prop found_index run execute store result score #tmp editor run data get storage rhythm_axe:prop found_index
execute if data storage rhythm_axe:prop found_index run scoreboard players add #tmp editor 1
execute if data storage rhythm_axe:prop found_index run execute store result storage rhythm_axe:prop flip_cursor int 1 run scoreboard players get #tmp editor
data remove storage rhythm_axe:prop note_id
data remove storage rhythm_axe:prop found_index
