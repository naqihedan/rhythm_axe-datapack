# 确认：临时副本 he_events 写回 editing.temp.hit_events，清理临时数据，返回音符面板
data modify storage rhythm_axe:maps.editor editing.temp.hit_events set from storage rhythm_axe:maps.editor editing.he_events
data remove storage rhythm_axe:maps.editor editing.he_events
data remove storage rhythm_axe:maps.editor editing.he_clipboard
data modify storage rhythm_axe:maps.editor feedback set value "已修改击打特效（确认后生效）"
data modify storage rhythm_axe:maps.editor no_undo set value 1b
function rhythm_axe:editor/menu/note/panel/note_panel