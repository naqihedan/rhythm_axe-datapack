#arg:cursor,index,cmd_index
# 事件指令行遍历
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].events[$(index)].commands[$(cmd_index)] run function rhythm_axe:editor/menu/event/list/event_list_cmd_line with storage rhythm_axe:prop
$execute unless data storage rhythm_axe:maps.editor history[$(cursor)].events[$(index)].commands[$(cmd_index)] run return 0
execute store result score #temp_playhead editor run data get storage rhythm_axe:prop cmd_index
scoreboard players add #temp_playhead editor 1
execute store result storage rhythm_axe:prop cmd_index int 1 run scoreboard players get #temp_playhead editor
function rhythm_axe:editor/menu/event/list/event_list_cmd_row with storage rhythm_axe:prop
