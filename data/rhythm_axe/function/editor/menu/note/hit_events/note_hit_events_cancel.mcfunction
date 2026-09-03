# 取消：丢弃临时副本 he_events 与剪贴板，返回音符面板
data remove storage rhythm_axe:maps.editor editing.he_events
data remove storage rhythm_axe:maps.editor editing.he_clipboard
data modify storage rhythm_axe:maps.editor feedback set value "已取消击打事件修改"
data modify storage rhythm_axe:maps.editor no_undo set value 1b
function rhythm_axe:editor/menu/note/panel/note_panel