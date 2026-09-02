#arg:cursor,index
# 打开已有事件点的设置面板：暂存副本 editing.temp（编辑只改暂存，【确认】才写回并进历史）
data modify storage rhythm_axe:maps.editor current_panel set value 6
data modify storage rhythm_axe:maps.editor editing set value {}
$data modify storage rhythm_axe:maps.editor editing.ref set value $(index)
$data modify storage rhythm_axe:maps.editor editing.temp set from storage rhythm_axe:maps.editor history[$(cursor)].events[$(index)]
# 旧事件可能缺字段，补缺省值
execute unless data storage rhythm_axe:maps.editor editing.temp.time run data modify storage rhythm_axe:maps.editor editing.temp.time set value 0
execute unless data storage rhythm_axe:maps.editor editing.temp.commands run data modify storage rhythm_axe:maps.editor editing.temp.commands set value []
function rhythm_axe:editor/menu/event/panel/event_panel
