# 初始角度设为玩家当前朝向（只改暂存 panel_temp）
data modify storage rhythm_axe:maps.editor panel_temp.spawn_yaw set from entity @s Rotation[0]
data modify storage rhythm_axe:maps.editor panel_temp.spawn_pitch set from entity @s Rotation[1]
function rhythm_axe:editor/menu/map/panel/map_panel_refresh
