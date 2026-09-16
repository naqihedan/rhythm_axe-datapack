#arg:sel_idx
# 复制选中音符：动态行复制列（值 = 100000 + 页内序×100 + 5）→ sel_idx = 页内序 + sel_page×40
#   → selection[sel_idx] 取 id → find_by_id → 复制到 note_clip → 重开已选定列表刷新面板（2026-09-16）
data modify storage rhythm_axe:prop cursor set from storage rhythm_axe:maps.editor history_cursor
$execute store result storage rhythm_axe:prop note_id int 1 run data get storage rhythm_axe:maps.editor selection[$(sel_idx)]
data modify storage rhythm_axe:prop index set value 0
data remove storage rhythm_axe:prop found_index
function rhythm_axe:editor/util/find_by_id
execute unless data storage rhythm_axe:prop found_index run tellraw @s [{"text":"[编辑器] 该音符不存在","color":"red"}]
execute unless data storage rhythm_axe:prop found_index run return fail
execute if data storage rhythm_axe:prop found_index run data modify storage rhythm_axe:prop index set from storage rhythm_axe:prop found_index
function rhythm_axe:editor/menu/note/list/note_list_copy_ with storage rhythm_axe:prop
data remove storage rhythm_axe:prop cursor
data remove storage rhythm_axe:prop index
data remove storage rhythm_axe:prop note_id
data remove storage rhythm_axe:prop found_index
# ★ 2026-09-16 用户要求：行级复制后重开已选定列表刷新面板（此前只发绿色聊天行，面板看起来“没反应”）
#   复制不产生撤销快照 → 打 no_undo → show_feedback 走纯文本反馈（渲染后自行清 feedback/no_undo）
data modify storage rhythm_axe:maps.editor feedback set value "已复制音符信息"
data modify storage rhythm_axe:maps.editor no_undo set value 1b
function rhythm_axe:editor/menu/note/selected/sel_note_list_open
