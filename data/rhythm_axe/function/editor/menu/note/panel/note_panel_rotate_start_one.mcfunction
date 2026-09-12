#arg:cursor,index
# 旋转 start_pos 单个音符（宏叶子）：start_pos 是相对判定位置的偏移向量 → 按 #flip_axis 绕原点旋转后写回
# 右手定则：绕X: y'=(sy·cos−sz·sin)/1e4, z'=(sy·sin+sz·cos)/1e4
#           绕Y: x'=(sx·cos+sz·sin)/1e4, z'=(−sx·sin+sz·cos)/1e4
#           绕Z: x'=(sx·cos−sy·sin)/1e4, y'=(sx·sin+sy·cos)/1e4
$execute store result score #sx editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].start_pos[0] 100
$execute store result score #sy editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].start_pos[1] 100
$execute store result score #sz editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].start_pos[2] 100
# —— 绕 X 轴 ——
execute if score #flip_axis editor matches 0 run scoreboard players operation #t1 editor = #sy editor
execute if score #flip_axis editor matches 0 run scoreboard players operation #t1 editor *= #rot_cos editor
execute if score #flip_axis editor matches 0 run scoreboard players operation #t2 editor = #sz editor
execute if score #flip_axis editor matches 0 run scoreboard players operation #t2 editor *= #rot_sin editor
execute if score #flip_axis editor matches 0 run scoreboard players operation #t1 editor -= #t2 editor
execute if score #flip_axis editor matches 0 run scoreboard players operation #t1 editor /= 10000 const
execute if score #flip_axis editor matches 0 run scoreboard players operation #t2 editor = #sy editor
execute if score #flip_axis editor matches 0 run scoreboard players operation #t2 editor *= #rot_sin editor
execute if score #flip_axis editor matches 0 run scoreboard players operation #t3 editor = #sz editor
execute if score #flip_axis editor matches 0 run scoreboard players operation #t3 editor *= #rot_cos editor
execute if score #flip_axis editor matches 0 run scoreboard players operation #t2 editor += #t3 editor
execute if score #flip_axis editor matches 0 run scoreboard players operation #t2 editor /= 10000 const
execute if score #flip_axis editor matches 0 run scoreboard players operation #sy editor = #t1 editor
execute if score #flip_axis editor matches 0 run scoreboard players operation #sz editor = #t2 editor
# —— 绕 Y 轴 ——
execute if score #flip_axis editor matches 1 run scoreboard players operation #t1 editor = #sx editor
execute if score #flip_axis editor matches 1 run scoreboard players operation #t1 editor *= #rot_cos editor
execute if score #flip_axis editor matches 1 run scoreboard players operation #t2 editor = #sz editor
execute if score #flip_axis editor matches 1 run scoreboard players operation #t2 editor *= #rot_sin editor
execute if score #flip_axis editor matches 1 run scoreboard players operation #t1 editor += #t2 editor
execute if score #flip_axis editor matches 1 run scoreboard players operation #t1 editor /= 10000 const
execute if score #flip_axis editor matches 1 run scoreboard players operation #t2 editor = #sz editor
execute if score #flip_axis editor matches 1 run scoreboard players operation #t2 editor *= #rot_cos editor
execute if score #flip_axis editor matches 1 run scoreboard players operation #t3 editor = #sx editor
execute if score #flip_axis editor matches 1 run scoreboard players operation #t3 editor *= #rot_sin editor
execute if score #flip_axis editor matches 1 run scoreboard players operation #t2 editor -= #t3 editor
execute if score #flip_axis editor matches 1 run scoreboard players operation #t2 editor /= 10000 const
execute if score #flip_axis editor matches 1 run scoreboard players operation #sx editor = #t1 editor
execute if score #flip_axis editor matches 1 run scoreboard players operation #sz editor = #t2 editor
# —— 绕 Z 轴 ——
execute if score #flip_axis editor matches 2 run scoreboard players operation #t1 editor = #sx editor
execute if score #flip_axis editor matches 2 run scoreboard players operation #t1 editor *= #rot_cos editor
execute if score #flip_axis editor matches 2 run scoreboard players operation #t2 editor = #sy editor
execute if score #flip_axis editor matches 2 run scoreboard players operation #t2 editor *= #rot_sin editor
execute if score #flip_axis editor matches 2 run scoreboard players operation #t1 editor -= #t2 editor
execute if score #flip_axis editor matches 2 run scoreboard players operation #t1 editor /= 10000 const
execute if score #flip_axis editor matches 2 run scoreboard players operation #t2 editor = #sx editor
execute if score #flip_axis editor matches 2 run scoreboard players operation #t2 editor *= #rot_sin editor
execute if score #flip_axis editor matches 2 run scoreboard players operation #t3 editor = #sy editor
execute if score #flip_axis editor matches 2 run scoreboard players operation #t3 editor *= #rot_cos editor
execute if score #flip_axis editor matches 2 run scoreboard players operation #t2 editor += #t3 editor
execute if score #flip_axis editor matches 2 run scoreboard players operation #t2 editor /= 10000 const
execute if score #flip_axis editor matches 2 run scoreboard players operation #sx editor = #t1 editor
execute if score #flip_axis editor matches 2 run scoreboard players operation #sy editor = #t2 editor
# 写回三轴
$execute store result storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].start_pos[0] double 0.01 run scoreboard players get #sx editor
$execute store result storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].start_pos[1] double 0.01 run scoreboard players get #sy editor
$execute store result storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].start_pos[2] double 0.01 run scoreboard players get #sz editor
