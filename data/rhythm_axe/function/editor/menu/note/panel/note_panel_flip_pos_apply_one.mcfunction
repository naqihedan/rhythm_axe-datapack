#arg:cursor,index,flip_axis
# 判定位置轴镜像应用单个音符（宏叶子）：position[$(flip_axis)] = min + max - old（原位写回，不重排）
$execute store result score #p_val editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].position[$(flip_axis)] 100
scoreboard players operation #p_new editor = #flip_min editor
scoreboard players operation #p_new editor += #flip_max editor
scoreboard players operation #p_new editor -= #p_val editor
$execute store result storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].position[$(flip_axis)] double 0.01 run scoreboard players get #p_new editor
