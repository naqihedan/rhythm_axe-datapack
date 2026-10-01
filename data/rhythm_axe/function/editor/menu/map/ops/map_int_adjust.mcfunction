#arg:field_name,delta,min,max
# 整数根字段加减（带值域钳制；只改暂存 panel_temp）—— 与 map_adjust 的区别：
#   map_adjust 固定「最小 1」（人数/血量那种必须 ≥1 的字段），本函数用调用方给的 min（预览起点可以从 0 开始）
# delta 经分数中转：写成「+= $(delta) const」时，const 表里没有该值会读作 0（按钮静默失效）；
# 而 26.2 的 scoreboard players add 不接受负数，所以只能「set 到 #delta 再用 operation 加」。
$scoreboard players set #delta editor $(delta)
$execute store result score #temp editor run data get storage rhythm_axe:maps.editor panel_temp.$(field_name)
scoreboard players operation #temp editor += #delta editor
$execute if score #temp editor matches ..$(min) run scoreboard players set #temp editor $(min)
$execute if score #temp editor matches $(max).. run scoreboard players set #temp editor $(max)
$execute store result storage rhythm_axe:maps.editor panel_temp.$(field_name) int 1 run scoreboard players get #temp editor
data remove storage rhythm_axe:prop field_name
data remove storage rhythm_axe:prop delta
data remove storage rhythm_axe:prop min
data remove storage rhythm_axe:prop max
function rhythm_axe:editor/menu/map/panel/map_panel_refresh
