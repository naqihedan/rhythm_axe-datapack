#arg:cursor,index
# 同时翻转起始位置应用单个音符（宏叶子）：按 #mirror_x/y/z 对 start_pos 对应轴取反（绕判定位置镜像；仅处理开启的轴）
$execute if score #mirror_x editor matches 1 run execute store result score #s0 editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].start_pos[0] 100
execute if score #mirror_x editor matches 1 run scoreboard players operation #s0 editor *= -1 const
$execute if score #mirror_x editor matches 1 run execute store result storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].start_pos[0] double 0.01 run scoreboard players get #s0 editor
$execute if score #mirror_y editor matches 1 run execute store result score #s1 editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].start_pos[1] 100
execute if score #mirror_y editor matches 1 run scoreboard players operation #s1 editor *= -1 const
$execute if score #mirror_y editor matches 1 run execute store result storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].start_pos[1] double 0.01 run scoreboard players get #s1 editor
$execute if score #mirror_z editor matches 1 run execute store result score #s2 editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].start_pos[2] 100
execute if score #mirror_z editor matches 1 run scoreboard players operation #s2 editor *= -1 const
$execute if score #mirror_z editor matches 1 run execute store result storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].start_pos[2] double 0.01 run scoreboard players get #s2 editor

