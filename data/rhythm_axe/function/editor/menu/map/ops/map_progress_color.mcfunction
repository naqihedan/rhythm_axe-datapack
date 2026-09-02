#arg: delta
# 谱面进度条颜色加减（0-6 循环）：0白 1粉 2蓝 3红 4绿 5黄 6紫（bossbar 支持色；只改暂存 panel_temp）
execute store result score #temp editor run data get storage rhythm_axe:maps.editor panel_temp.progress_color
$scoreboard players operation #temp editor += $(delta) const
execute if score #temp editor matches 7.. run scoreboard players set #temp editor 0
execute if score #temp editor matches ..-1 run scoreboard players set #temp editor 6
execute store result storage rhythm_axe:maps.editor panel_temp.progress_color int 1 run scoreboard players get #temp editor
data remove storage rhythm_axe:prop delta
function rhythm_axe:editor/menu/map/panel/map_panel_refresh
