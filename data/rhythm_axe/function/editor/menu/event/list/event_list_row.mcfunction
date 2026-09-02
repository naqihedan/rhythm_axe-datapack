#arg:cursor,index,end,page
# 事件列表行遍历：每行 4 个按钮（编辑 401+、复制 411+、粘贴 421+、删除 431+页内序号）
execute store result score #temp_playhead editor run data get storage rhythm_axe:prop index
execute store result score #temp_cursor editor run data get storage rhythm_axe:prop page
scoreboard players set #index editor 5
scoreboard players operation #temp_cursor editor *= #index editor
scoreboard players operation #temp_playhead editor -= #temp_cursor editor
scoreboard players add #temp_playhead editor 401
execute store result storage rhythm_axe:prop edit_val int 1 run scoreboard players get #temp_playhead editor
scoreboard players add #temp_playhead editor 10
execute store result storage rhythm_axe:prop copy_val int 1 run scoreboard players get #temp_playhead editor
scoreboard players add #temp_playhead editor 10
execute store result storage rhythm_axe:prop paste_val int 1 run scoreboard players get #temp_playhead editor
scoreboard players add #temp_playhead editor 10
execute store result storage rhythm_axe:prop delete_val int 1 run scoreboard players get #temp_playhead editor
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].events[$(index)] run function rhythm_axe:editor/menu/event/list/event_list_line with storage rhythm_axe:prop
$execute unless data storage rhythm_axe:maps.editor history[$(cursor)].events[$(index)] run return 0
# 已到本页末尾则结束
execute store result score #temp_playhead editor run data get storage rhythm_axe:prop index
$execute if score #temp_playhead editor matches $(end).. run return 0
# 行号 +1 后递归
scoreboard players add #temp_playhead editor 1
execute store result storage rhythm_axe:prop index int 1 run scoreboard players get #temp_playhead editor
function rhythm_axe:editor/menu/event/list/event_list_row with storage rhythm_axe:prop
