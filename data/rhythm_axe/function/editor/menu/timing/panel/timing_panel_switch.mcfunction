#arg:cursor,index
# 面板切换到 index 处的时间点（重载暂存 temp 并刷新）
data remove storage rhythm_axe:maps.editor editing.is_new
$data modify storage rhythm_axe:maps.editor editing.ref set value $(index)
$data modify storage rhythm_axe:maps.editor editing.temp set from storage rhythm_axe:maps.editor history[$(cursor)].timing_points[$(index)]
function rhythm_axe:editor/menu/timing/panel/timing_panel
