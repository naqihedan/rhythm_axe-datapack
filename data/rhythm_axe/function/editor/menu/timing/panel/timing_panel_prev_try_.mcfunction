#arg:cursor,index
# 上一个时间点存在则切换，不存在则提示
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].timing_points[$(index)] run function rhythm_axe:editor/menu/timing/panel/timing_panel_switch with storage rhythm_axe:prop
$execute unless data storage rhythm_axe:maps.editor history[$(cursor)].timing_points[$(index)] run tellraw @s [{"text":"[编辑器] 没有上一个时间点","color":"red"}]
