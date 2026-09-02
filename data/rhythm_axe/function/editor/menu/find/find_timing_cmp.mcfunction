#arg:cursor,index
# 比较时间点的 time 与查找目标，匹配则输出
$execute store result score #timing_time editor run data get storage rhythm_axe:maps.editor history[$(cursor)].timing_points[$(index)].time
execute if score #timing_time editor = #target_id editor run tellraw @s [{"text":"[查找] 时间点索引 ","color":"green"},{"nbt":"index","storage":"rhythm_axe:prop","color":"aqua"},{"text":"：time ","color":"gray"},{"score":{"name":"#timing_time","objective":"editor"},"color":"white"}]
