#arg:idx
# 复制第 $(idx) 条指令（内容+启用状态）到剪贴板 editing.he_clipboard
$data modify storage rhythm_axe:maps.editor editing.he_clipboard set from storage rhythm_axe:maps.editor editing.he_events[$(idx)]
data modify storage rhythm_axe:maps.editor feedback set value "已复制击打特效指令"
data modify storage rhythm_axe:maps.editor no_undo set value 1b
function rhythm_axe:editor/menu/note/hit_events/note_hit_events_panel