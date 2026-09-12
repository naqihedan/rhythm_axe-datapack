#arg:cursor,index
# 旋转应用单个音符（宏叶子）：读 position[0/1/2]（×100）→ 按 #flip_axis 绕包围盒中心 #rc0/1/2 旋转 → 写回
# 右手定则（逆时针）：绕X: y'=rc1+(dy·cos−dz·sin)/1e4, z'=rc2+(dy·sin+dz·cos)/1e4
#                     绕Y: x'=rc0+(dx·cos+dz·sin)/1e4, z'=rc2+(−dx·sin+dz·cos)/1e4
#                     绕Z: x'=rc0+(dx·cos−dy·sin)/1e4, y'=rc1+(dx·sin+dy·cos)/1e4
$execute store result score #rx editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].position[0] 100
$execute store result score #ry editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].position[1] 100
$execute store result score #rz editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].position[2] 100
# —— 绕 X 轴（#flip_axis=0）：y,z 变化 ——
execute if score #flip_axis editor matches 0 run scoreboard players operation #dy editor = #ry editor
execute if score #flip_axis editor matches 0 run scoreboard players operation #dy editor -= #rc1 editor
execute if score #flip_axis editor matches 0 run scoreboard players operation #dz editor = #rz editor
execute if score #flip_axis editor matches 0 run scoreboard players operation #dz editor -= #rc2 editor
execute if score #flip_axis editor matches 0 run scoreboard players operation #t1 editor = #dy editor
execute if score #flip_axis editor matches 0 run scoreboard players operation #t1 editor *= #rot_cos editor
execute if score #flip_axis editor matches 0 run scoreboard players operation #t2 editor = #dz editor
execute if score #flip_axis editor matches 0 run scoreboard players operation #t2 editor *= #rot_sin editor
execute if score #flip_axis editor matches 0 run scoreboard players operation #t1 editor -= #t2 editor
execute if score #flip_axis editor matches 0 run scoreboard players operation #t1 editor /= 10000 const
execute if score #flip_axis editor matches 0 run scoreboard players operation #t2 editor = #dy editor
execute if score #flip_axis editor matches 0 run scoreboard players operation #t2 editor *= #rot_sin editor
execute if score #flip_axis editor matches 0 run scoreboard players operation #t3 editor = #dz editor
execute if score #flip_axis editor matches 0 run scoreboard players operation #t3 editor *= #rot_cos editor
execute if score #flip_axis editor matches 0 run scoreboard players operation #t2 editor += #t3 editor
execute if score #flip_axis editor matches 0 run scoreboard players operation #t2 editor /= 10000 const
execute if score #flip_axis editor matches 0 run scoreboard players operation #ry editor = #rc1 editor
execute if score #flip_axis editor matches 0 run scoreboard players operation #ry editor += #t1 editor
execute if score #flip_axis editor matches 0 run scoreboard players operation #rz editor = #rc2 editor
execute if score #flip_axis editor matches 0 run scoreboard players operation #rz editor += #t2 editor
# —— 绕 Y 轴（#flip_axis=1）：x,z 变化 ——
execute if score #flip_axis editor matches 1 run scoreboard players operation #dx editor = #rx editor
execute if score #flip_axis editor matches 1 run scoreboard players operation #dx editor -= #rc0 editor
execute if score #flip_axis editor matches 1 run scoreboard players operation #dz editor = #rz editor
execute if score #flip_axis editor matches 1 run scoreboard players operation #dz editor -= #rc2 editor
execute if score #flip_axis editor matches 1 run scoreboard players operation #t1 editor = #dx editor
execute if score #flip_axis editor matches 1 run scoreboard players operation #t1 editor *= #rot_cos editor
execute if score #flip_axis editor matches 1 run scoreboard players operation #t2 editor = #dz editor
execute if score #flip_axis editor matches 1 run scoreboard players operation #t2 editor *= #rot_sin editor
execute if score #flip_axis editor matches 1 run scoreboard players operation #t1 editor += #t2 editor
execute if score #flip_axis editor matches 1 run scoreboard players operation #t1 editor /= 10000 const
execute if score #flip_axis editor matches 1 run scoreboard players operation #t2 editor = #dz editor
execute if score #flip_axis editor matches 1 run scoreboard players operation #t2 editor *= #rot_cos editor
execute if score #flip_axis editor matches 1 run scoreboard players operation #t3 editor = #dx editor
execute if score #flip_axis editor matches 1 run scoreboard players operation #t3 editor *= #rot_sin editor
execute if score #flip_axis editor matches 1 run scoreboard players operation #t2 editor -= #t3 editor
execute if score #flip_axis editor matches 1 run scoreboard players operation #t2 editor /= 10000 const
execute if score #flip_axis editor matches 1 run scoreboard players operation #rx editor = #rc0 editor
execute if score #flip_axis editor matches 1 run scoreboard players operation #rx editor += #t1 editor
execute if score #flip_axis editor matches 1 run scoreboard players operation #rz editor = #rc2 editor
execute if score #flip_axis editor matches 1 run scoreboard players operation #rz editor += #t2 editor
# —— 绕 Z 轴（#flip_axis=2）：x,y 变化 ——
execute if score #flip_axis editor matches 2 run scoreboard players operation #dx editor = #rx editor
execute if score #flip_axis editor matches 2 run scoreboard players operation #dx editor -= #rc0 editor
execute if score #flip_axis editor matches 2 run scoreboard players operation #dy editor = #ry editor
execute if score #flip_axis editor matches 2 run scoreboard players operation #dy editor -= #rc1 editor
execute if score #flip_axis editor matches 2 run scoreboard players operation #t1 editor = #dx editor
execute if score #flip_axis editor matches 2 run scoreboard players operation #t1 editor *= #rot_cos editor
execute if score #flip_axis editor matches 2 run scoreboard players operation #t2 editor = #dy editor
execute if score #flip_axis editor matches 2 run scoreboard players operation #t2 editor *= #rot_sin editor
execute if score #flip_axis editor matches 2 run scoreboard players operation #t1 editor -= #t2 editor
execute if score #flip_axis editor matches 2 run scoreboard players operation #t1 editor /= 10000 const
execute if score #flip_axis editor matches 2 run scoreboard players operation #t2 editor = #dx editor
execute if score #flip_axis editor matches 2 run scoreboard players operation #t2 editor *= #rot_sin editor
execute if score #flip_axis editor matches 2 run scoreboard players operation #t3 editor = #dy editor
execute if score #flip_axis editor matches 2 run scoreboard players operation #t3 editor *= #rot_cos editor
execute if score #flip_axis editor matches 2 run scoreboard players operation #t2 editor += #t3 editor
execute if score #flip_axis editor matches 2 run scoreboard players operation #t2 editor /= 10000 const
execute if score #flip_axis editor matches 2 run scoreboard players operation #rx editor = #rc0 editor
execute if score #flip_axis editor matches 2 run scoreboard players operation #rx editor += #t1 editor
execute if score #flip_axis editor matches 2 run scoreboard players operation #ry editor = #rc1 editor
execute if score #flip_axis editor matches 2 run scoreboard players operation #ry editor += #t2 editor
# 写回三轴
$execute store result storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].position[0] double 0.01 run scoreboard players get #rx editor
$execute store result storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].position[1] double 0.01 run scoreboard players get #ry editor
$execute store result storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].position[2] double 0.01 run scoreboard players get #rz editor
