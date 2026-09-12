#arg:cursor
# 读工作副本 notes 长度（供 time_select_drive 遍历终止）；读取失败按 0 处理
scoreboard players set #ts_len editor 0
$execute store result score #ts_len editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes
