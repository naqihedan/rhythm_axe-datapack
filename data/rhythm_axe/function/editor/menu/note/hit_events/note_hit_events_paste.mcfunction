#arg:idx
# 粘贴：把剪贴板内容覆盖到第 $(idx) 行（剪贴板有内容才执行；粘贴到当前行，与编辑对话框语义一致）
$execute if data storage rhythm_axe:maps.editor editing.he_clipboard run data modify storage rhythm_axe:maps.editor editing.he_events[$(idx)] set from storage rhythm_axe:maps.editor editing.he_clipboard
execute if data storage rhythm_axe:maps.editor editing.he_clipboard run data modify storage rhythm_axe:maps.editor feedback set value "已粘贴到该行"
execute if data storage rhythm_axe:maps.editor editing.he_clipboard run data modify storage rhythm_axe:maps.editor no_undo set value 1b
execute unless data storage rhythm_axe:maps.editor editing.he_clipboard run data modify storage rhythm_axe:maps.editor feedback set value "没有可粘贴的指令"
execute unless data storage rhythm_axe:maps.editor editing.he_clipboard run data modify storage rhythm_axe:maps.editor no_undo set value 1b
function rhythm_axe:editor/menu/note/hit_events/note_hit_events_panel