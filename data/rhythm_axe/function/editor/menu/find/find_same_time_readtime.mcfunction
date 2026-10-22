#arg:cursor,i
# 读 time 辅助叶子（由 find_same_time_scan_drive 调用）：notes[i].time 存在 → 读进 prop.st_time
# （拆成独立叶子是因为驱动器本身不是宏函数，不能直接写 $(cursor)/$(i) 宏行）
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(i)].time run execute store result storage rhythm_axe:prop st_time int 1 run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(i)].time
