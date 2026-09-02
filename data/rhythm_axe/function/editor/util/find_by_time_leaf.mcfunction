#arg:cursor,list_name,index
# 按 time 查找的"叶子"（宏）：只处理当前这一个元素，不递归。
# #find_done：1=命中（写 found_index） 2=元素缺失（遍历结束） 0=未命中继续
# 目标 time 在 prop.target_time。
$execute unless data storage rhythm_axe:maps.editor history[$(cursor)].$(list_name)[$(index)] run scoreboard players set #find_done editor 2
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].$(list_name)[$(index)] run execute store result score #elem_time editor run data get storage rhythm_axe:maps.editor history[$(cursor)].$(list_name)[$(index)].time
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].$(list_name)[$(index)] run execute store result score #target_time editor run data get storage rhythm_axe:prop target_time
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].$(list_name)[$(index)] if score #elem_time editor = #target_time editor run data modify storage rhythm_axe:prop found_index set from storage rhythm_axe:prop index
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].$(list_name)[$(index)] if score #elem_time editor = #target_time editor run scoreboard players set #find_done editor 1
