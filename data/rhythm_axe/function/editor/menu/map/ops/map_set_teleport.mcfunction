#arg:value
# 设置传送玩家开关（只改暂存 panel_temp，保存设置才写回）
$data modify storage rhythm_axe:maps.editor panel_temp.teleport set value $(value)
function rhythm_axe:editor/menu/map/panel/map_panel_refresh
