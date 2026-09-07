#arg:cursor,index
# 时间轴翻转扫描单个音符（宏叶子）：读 history[$(cursor)].notes[$(index)].time，更新 #flip_min/#flip_max
$execute store result score #note_time editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].time
execute if score #note_time editor < #flip_min editor run scoreboard players operation #flip_min editor = #note_time editor
execute if score #note_time editor > #flip_max editor run scoreboard players operation #flip_max editor = #note_time editor
