#arg:cursor,index
# 下一个事件存在则切换，不存在则提示
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].events[$(index)] run function rhythm_axe:editor/menu/event/panel/event_panel_switch with storage rhythm_axe:prop
$execute unless data storage rhythm_axe:maps.editor history[$(cursor)].events[$(index)] run tellraw @s [{"text":"[编辑器] 没有下一个事件","color":"red"}]
