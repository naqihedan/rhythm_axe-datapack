# 确认新增事件点：从暂存 editing.temp 创建（一次历史快照）
data modify storage rhythm_axe:maps.editor op_label set value "创建事件"
data modify storage rhythm_axe:prop time set from storage rhythm_axe:maps.editor editing.temp.time
data modify storage rhythm_axe:prop commands set from storage rhythm_axe:maps.editor editing.temp.commands
function rhythm_axe:editor/event/create
data modify storage rhythm_axe:maps.editor feedback set value "已创建事件点"
data remove storage rhythm_axe:maps.editor editing
function rhythm_axe:editor/menu/event/list/event_list_open
