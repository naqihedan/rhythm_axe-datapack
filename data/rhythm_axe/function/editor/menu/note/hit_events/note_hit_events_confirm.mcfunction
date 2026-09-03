# 确认：临时副本 he_events 写回 editing.temp.hit_events，清理临时数据，返回音符面板
data modify storage rhythm_axe:maps.editor editing.temp.hit_events set from storage rhythm_axe:maps.editor editing.he_events
# 批量模式：标记击打事件字段被改动（确认时对全部选中应用同值）
execute if data storage rhythm_axe:maps.editor editing.batch run data modify storage rhythm_axe:maps.editor editing.batch_set.hit_events set value 1b
execute if data storage rhythm_axe:maps.editor editing.batch run data modify storage rhythm_axe:maps.editor editing.changed.hit_events set value 1b
data remove storage rhythm_axe:maps.editor editing.he_events
data remove storage rhythm_axe:maps.editor editing.he_clipboard
data modify storage rhythm_axe:maps.editor feedback set value "已修改击打事件（确认后生效）"
data modify storage rhythm_axe:maps.editor no_undo set value 1b
function rhythm_axe:editor/menu/note/panel/note_panel