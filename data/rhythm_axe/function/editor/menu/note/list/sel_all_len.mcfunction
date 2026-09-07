#arg:cursor
# 读工作副本 notes 长度（供 sel_all_drive 遍历终止）
$execute store result score #notes_len editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes
