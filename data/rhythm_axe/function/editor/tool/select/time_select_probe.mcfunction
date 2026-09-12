#arg:cursor,i
# 二分查找探针：只把 notes[i].time 读进 #ts_time 供 time_select_find 比较
# 参数空间 (cursor,i) 与 time_select_judge / sel_rebuild_judge 一致 → 宏展开缓存可复用
$execute store result score #ts_time editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(i)].time
