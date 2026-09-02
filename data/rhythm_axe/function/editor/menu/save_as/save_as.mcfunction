# 另存为新谱面：有未保存内容先确认，否则直接另存
execute store result score #temp_cursor editor run data get storage rhythm_axe:maps.editor history_cursor
execute store result score #temp editor run data get storage rhythm_axe:maps.editor saved_cursor
execute unless score #temp_cursor editor = #temp editor run function rhythm_axe:editor/menu/save_as/save_as_confirm_open
execute if score #temp_cursor editor = #temp editor run function rhythm_axe:editor/menu/save_as/save_as_go
