#arg:cursor,index
# 查找事件点遍历：time == #target_id 输出索引行
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].events[$(index)] run function rhythm_axe:editor/menu/find/find_event_cmp with storage rhythm_axe:prop
$execute unless data storage rhythm_axe:maps.editor history[$(cursor)].events[$(index)] run return 0
execute store result score #temp_playhead editor run data get storage rhythm_axe:prop index
scoreboard players add #temp_playhead editor 1
execute store result storage rhythm_axe:prop index int 1 run scoreboard players get #temp_playhead editor
function rhythm_axe:editor/menu/find/find_event_ with storage rhythm_axe:prop
