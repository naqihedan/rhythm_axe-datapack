#arg:cmd_index
# 事件指令行遍历：编辑按钮值 = 511+序号，删除按钮值 = 561+序号
execute store result score #temp_playhead editor run data get storage rhythm_axe:prop cmd_index
scoreboard players operation #temp editor = #temp_playhead editor
scoreboard players add #temp editor 511
execute store result storage rhythm_axe:prop edit_val int 1 run scoreboard players get #temp editor
scoreboard players operation #temp editor = #temp_playhead editor
scoreboard players add #temp editor 561
execute store result storage rhythm_axe:prop delete_val int 1 run scoreboard players get #temp editor
scoreboard players add #temp_playhead editor 1
$execute if data storage rhythm_axe:maps.editor editing.temp.commands[$(cmd_index)] run function rhythm_axe:editor/menu/event/panel/event_panel_cmd_line with storage rhythm_axe:prop
$execute unless data storage rhythm_axe:maps.editor editing.temp.commands[$(cmd_index)] run return 0
execute store result score #temp_playhead editor run data get storage rhythm_axe:prop cmd_index
scoreboard players add #temp_playhead editor 1
execute store result storage rhythm_axe:prop cmd_index int 1 run scoreboard players get #temp_playhead editor
function rhythm_axe:editor/menu/event/panel/event_panel_cmd_row with storage rhythm_axe:prop
