#arg:cursor,st_found
# 读 time 辅助叶子（由 find_same_time_collect_drive 调用）：notes[st_found].time 存在 → 读进 prop.st_time
# （st_found 是驱动器读好的**新值**宏参数；拆独立叶子是因为驱动器本身不是宏函数）
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(st_found)].time run execute store result storage rhythm_axe:prop st_time int 1 run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(st_found)].time
