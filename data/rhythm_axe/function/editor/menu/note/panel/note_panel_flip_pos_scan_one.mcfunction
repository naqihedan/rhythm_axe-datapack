#arg:cursor,index,flip_axis
# 判定位置轴镜像扫描单个音符（宏叶子）：读 position[$(flip_axis)]（×100），更新 #flip_min/#flip_max
$execute store result score #p_val editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].position[$(flip_axis)] 100
execute if score #p_val editor < #flip_min editor run scoreboard players operation #flip_min editor = #p_val editor
execute if score #p_val editor > #flip_max editor run scoreboard players operation #flip_max editor = #p_val editor
