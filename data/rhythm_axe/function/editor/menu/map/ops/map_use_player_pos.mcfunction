# 初始位置设为玩家当前位置（只改暂存 panel_temp）
data modify storage rhythm_axe:maps.editor panel_temp.spawn_x set from entity @s Pos[0]
data modify storage rhythm_axe:maps.editor panel_temp.spawn_y set from entity @s Pos[1]
data modify storage rhythm_axe:maps.editor panel_temp.spawn_z set from entity @s Pos[2]
function rhythm_axe:editor/menu/map/panel/map_panel_refresh
