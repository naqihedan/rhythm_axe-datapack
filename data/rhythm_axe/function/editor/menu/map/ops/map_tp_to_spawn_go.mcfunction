# 拆 spawn 标量到 prop 后传送（暂存面板的值可能未保存，按面板当前值传送）
data modify storage rhythm_axe:prop spawn_x set from storage rhythm_axe:maps.editor panel_temp.spawn_x
data modify storage rhythm_axe:prop spawn_y set from storage rhythm_axe:maps.editor panel_temp.spawn_y
data modify storage rhythm_axe:prop spawn_z set from storage rhythm_axe:maps.editor panel_temp.spawn_z
data modify storage rhythm_axe:prop spawn_yaw set from storage rhythm_axe:maps.editor panel_temp.spawn_yaw
data modify storage rhythm_axe:prop spawn_pitch set from storage rhythm_axe:maps.editor panel_temp.spawn_pitch
function rhythm_axe:editor/tp_to_spawn with storage rhythm_axe:prop
data remove storage rhythm_axe:prop spawn_x
data remove storage rhythm_axe:prop spawn_y
data remove storage rhythm_axe:prop spawn_z
data remove storage rhythm_axe:prop spawn_yaw
data remove storage rhythm_axe:prop spawn_pitch
tellraw @s [{"text":"[编辑器] 已传送到谱面初始位置","color":"green"}]
