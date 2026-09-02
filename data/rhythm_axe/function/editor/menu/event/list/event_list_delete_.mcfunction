#arg:cursor,index
# 删除该事件（一次历史快照）
function rhythm_axe:editor/file/begin
data modify storage rhythm_axe:maps.editor op_label set value "删除事件"
$data remove storage rhythm_axe:maps.editor history[$(cursor)].events[$(index)]
function rhythm_axe:editor/file/commit
function rhythm_axe:editor/refresh
data modify storage rhythm_axe:maps.editor feedback set value "已删除事件"
function rhythm_axe:editor/menu/event/list/event_list_open
