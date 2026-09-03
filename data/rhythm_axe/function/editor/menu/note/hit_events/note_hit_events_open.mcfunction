# 进入击打事件二级菜单（面板 14）：复制 hit_events 到临时副本 editing.he_events，清空剪贴板
data modify storage rhythm_axe:maps.editor editing.he_events set value []
data modify storage rhythm_axe:maps.editor editing.he_events set from storage rhythm_axe:maps.editor editing.temp.hit_events
data remove storage rhythm_axe:maps.editor editing.he_clipboard
data modify storage rhythm_axe:maps.editor current_panel set value 14
function rhythm_axe:editor/menu/note/hit_events/note_hit_events_panel