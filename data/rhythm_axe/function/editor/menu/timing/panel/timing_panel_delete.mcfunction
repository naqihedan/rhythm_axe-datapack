# 确认删除时间点（首个时间点不可删除）
execute store result score #index editor run data get storage rhythm_axe:maps.editor editing.ref
execute if score #index editor matches 0 run tellraw @s [{"text":"[编辑器] 不能删除曲目起始时间点","color":"red"}]
execute if score #index editor matches 0 run data remove storage rhythm_axe:maps.editor editing.delete_armed
execute if score #index editor matches 0 run function rhythm_axe:editor/menu/timing/panel/timing_panel
execute if score #index editor matches 1.. run function rhythm_axe:editor/menu/timing/panel/timing_panel_delete_go
