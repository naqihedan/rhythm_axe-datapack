#arg: cursor, index
# 把 #off_x / #off_y / #off_z（×1000）加到 history[$(cursor)].notes[$(index)].position（宏叶子）
$execute store result score #old_x editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].position[0] 1000
$execute store result score #old_y editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].position[1] 1000
$execute store result score #old_z editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].position[2] 1000
scoreboard players operation #new_x editor = #old_x editor
scoreboard players operation #new_x editor += #off_x editor
scoreboard players operation #new_y editor = #old_y editor
scoreboard players operation #new_y editor += #off_y editor
scoreboard players operation #new_z editor = #old_z editor
scoreboard players operation #new_z editor += #off_z editor
$execute store result storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].position[0] double 0.001 run scoreboard players get #new_x editor
$execute store result storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].position[1] double 0.001 run scoreboard players get #new_y editor
$execute store result storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].position[2] double 0.001 run scoreboard players get #new_z editor
