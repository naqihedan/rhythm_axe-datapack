#arg:cursor,index
# 面板切换到 index 处的事件（重载暂存 temp 并刷新）
data remove storage rhythm_axe:maps.editor editing.is_new
$data modify storage rhythm_axe:maps.editor editing.ref set value $(index)
$data modify storage rhythm_axe:maps.editor editing.temp set from storage rhythm_axe:maps.editor history[$(cursor)].events[$(index)]
function rhythm_axe:editor/menu/event/panel/event_panel
