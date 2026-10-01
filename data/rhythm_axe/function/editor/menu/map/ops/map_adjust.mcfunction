#arg:field_name,delta
# 整数根字段加减（health/player_count，值域 >=1；只改暂存 panel_temp）
# delta 经分数中转（勿写「+= $(delta) const」，const 表缺该值时会读 0 静默失效；add 又不收负数）
$scoreboard players set #delta editor $(delta)
$execute store result score #temp editor run data get storage rhythm_axe:maps.editor panel_temp.$(field_name)
scoreboard players operation #temp editor += #delta editor
execute if score #temp editor matches ..0 run scoreboard players set #temp editor 1
$execute store result storage rhythm_axe:maps.editor panel_temp.$(field_name) int 1 run scoreboard players get #temp editor
data remove storage rhythm_axe:prop field_name
data remove storage rhythm_axe:prop delta
function rhythm_axe:editor/menu/map/panel/map_panel_refresh
