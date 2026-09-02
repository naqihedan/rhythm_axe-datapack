#arg:field_name,delta,min,max
# 坐标/角度加减（spawn_x/y/z/yaw/pitch；scoreboard 存 ×100 值，delta 为 ±10（0.1 格）或 ±100（1°）；只改暂存 panel_temp）
# min/max 为 ×100 值域：位置无限制，角度 -18000~18000
$execute store result score #temp editor run data get storage rhythm_axe:maps.editor panel_temp.$(field_name) 100
$scoreboard players operation #temp editor += $(delta) const
$execute if score #temp editor matches ..$(min) run scoreboard players set #temp editor $(min)
$execute if score #temp editor matches $(max).. run scoreboard players set #temp editor $(max)
$execute store result storage rhythm_axe:maps.editor panel_temp.$(field_name) double 0.01 run scoreboard players get #temp editor
data remove storage rhythm_axe:prop field_name
data remove storage rhythm_axe:prop delta
data remove storage rhythm_axe:prop min
data remove storage rhythm_axe:prop max
function rhythm_axe:editor/menu/map/panel/map_panel_refresh
