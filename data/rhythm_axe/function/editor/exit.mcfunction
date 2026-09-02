# 退出编辑器（@s = 玩家）：未在编辑中提示；有未保存内容先确认，否则直接退出
execute store result score #temp editor run data get storage rhythm_axe:maps.editor active
execute if score #temp editor matches 0 run tellraw @s [{"text":"[编辑器] 没有正在编辑的谱面","color":"red"}]
execute if score #temp editor matches 0 run return fail
execute store result score #temp_cursor editor run data get storage rhythm_axe:maps.editor history_cursor
execute store result score #temp editor run data get storage rhythm_axe:maps.editor saved_cursor
execute unless score #temp_cursor editor = #temp editor run function rhythm_axe:editor/menu/exit/exit_confirm
execute if score #temp_cursor editor = #temp editor run function rhythm_axe:editor/exit_do
