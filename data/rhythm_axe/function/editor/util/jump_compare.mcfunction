#arg:cursor,index,list_name
# 读当前元素 time，按 jump_mode 交给 prev / next 检查
$execute store result score #timing_time editor run data get storage rhythm_axe:maps.editor history[$(cursor)].$(list_name)[$(index)].time
execute store result score #temp_playhead editor run data get storage rhythm_axe:maps.editor playhead
execute if data storage rhythm_axe:prop {jump_mode:"prev"} run function rhythm_axe:editor/util/jump_check_prev with storage rhythm_axe:prop
execute if data storage rhythm_axe:prop {jump_mode:"next"} run function rhythm_axe:editor/util/jump_check_next with storage rhythm_axe:prop
