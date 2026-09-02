# 切换传送玩家开关（只改暂存 panel_temp，保存设置才写回）
execute store result score #temp editor run data get storage rhythm_axe:maps.editor panel_temp.teleport
execute if score #temp editor matches 0 run data modify storage rhythm_axe:maps.editor panel_temp.teleport set value 1b
execute unless score #temp editor matches 0 run data modify storage rhythm_axe:maps.editor panel_temp.teleport set value 0b
function rhythm_axe:editor/menu/map/panel/map_panel_refresh
