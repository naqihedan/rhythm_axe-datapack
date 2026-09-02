#arg:idx
# 删除第 $(idx) 条指令并刷新面板
$data remove storage rhythm_axe:maps.editor editing.he_events[$(idx)]
function rhythm_axe:editor/menu/note/hit_events/note_hit_events_panel