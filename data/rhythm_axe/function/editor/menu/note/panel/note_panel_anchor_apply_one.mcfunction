#arg:cursor,index
# 应用锚点变换到单个音符（宏叶子）：position' = R(position − C)/1e4 + A；[S] 开时 start_pos' = R·start_pos/1e4
#   R = #r11..#r33（×1e4，行主序）、C = #rc0/1/2（×100）、A = #an_x/y/z（×100）
#   定点：位置 ×100、矩阵 ×1e4 ⇒ 乘积 ×1e6，除 1e4 回到 ×100；写回用 double 0.01（= 0.01 格分辨率）
#   ⚠️ 溢出前提：|P−C| ≤ 1e4（100 格）时 1e4×1e4=1e8、三轴和 ≤3e8 < 2^31 ✓（本库谱面位置都在几十格内）
$execute store result score #px editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].position[0] 100
$execute store result score #py editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].position[1] 100
$execute store result score #pz editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].position[2] 100
scoreboard players operation #dx editor = #px editor
scoreboard players operation #dx editor -= #rc0 editor
scoreboard players operation #dy editor = #py editor
scoreboard players operation #dy editor -= #rc1 editor
scoreboard players operation #dz editor = #pz editor
scoreboard players operation #dz editor -= #rc2 editor
# —— x' ——
scoreboard players operation #vx editor = #r11 editor
scoreboard players operation #vx editor *= #dx editor
scoreboard players operation #t1 editor = #r12 editor
scoreboard players operation #t1 editor *= #dy editor
scoreboard players operation #vx editor += #t1 editor
scoreboard players operation #t1 editor = #r13 editor
scoreboard players operation #t1 editor *= #dz editor
scoreboard players operation #vx editor += #t1 editor
scoreboard players operation #vx editor /= 10000 const
scoreboard players operation #vx editor += #an_x editor
# —— y' ——
scoreboard players operation #vy editor = #r21 editor
scoreboard players operation #vy editor *= #dx editor
scoreboard players operation #t1 editor = #r22 editor
scoreboard players operation #t1 editor *= #dy editor
scoreboard players operation #vy editor += #t1 editor
scoreboard players operation #t1 editor = #r23 editor
scoreboard players operation #t1 editor *= #dz editor
scoreboard players operation #vy editor += #t1 editor
scoreboard players operation #vy editor /= 10000 const
scoreboard players operation #vy editor += #an_y editor
# —— z' ——
scoreboard players operation #vz editor = #r31 editor
scoreboard players operation #vz editor *= #dx editor
scoreboard players operation #t1 editor = #r32 editor
scoreboard players operation #t1 editor *= #dy editor
scoreboard players operation #vz editor += #t1 editor
scoreboard players operation #t1 editor = #r33 editor
scoreboard players operation #t1 editor *= #dz editor
scoreboard players operation #vz editor += #t1 editor
scoreboard players operation #vz editor /= 10000 const
scoreboard players operation #vz editor += #an_z editor
$execute store result storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].position[0] double 0.01 run scoreboard players get #vx editor
$execute store result storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].position[1] double 0.01 run scoreboard players get #vy editor
$execute store result storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].position[2] double 0.01 run scoreboard players get #vz editor
# —— [S] 开：start_pos 也绕「该音符自己的判定位置」（= 原点）旋转，不平移；缩放已折进矩阵所以也一起缩放（哨兵 0 防 start_pos 缺失时读失败留旧值）——
scoreboard players set #sx editor 0
scoreboard players set #sy editor 0
scoreboard players set #sz editor 0
$execute if score #mirror_s editor matches 1 run execute store result score #sx editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].start_pos[0] 100
$execute if score #mirror_s editor matches 1 run execute store result score #sy editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].start_pos[1] 100
$execute if score #mirror_s editor matches 1 run execute store result score #sz editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].start_pos[2] 100
scoreboard players operation #ux editor = #r11 editor
scoreboard players operation #ux editor *= #sx editor
scoreboard players operation #t1 editor = #r12 editor
scoreboard players operation #t1 editor *= #sy editor
scoreboard players operation #ux editor += #t1 editor
scoreboard players operation #t1 editor = #r13 editor
scoreboard players operation #t1 editor *= #sz editor
scoreboard players operation #ux editor += #t1 editor
scoreboard players operation #ux editor /= 10000 const
scoreboard players operation #uy editor = #r21 editor
scoreboard players operation #uy editor *= #sx editor
scoreboard players operation #t1 editor = #r22 editor
scoreboard players operation #t1 editor *= #sy editor
scoreboard players operation #uy editor += #t1 editor
scoreboard players operation #t1 editor = #r23 editor
scoreboard players operation #t1 editor *= #sz editor
scoreboard players operation #uy editor += #t1 editor
scoreboard players operation #uy editor /= 10000 const
scoreboard players operation #uz editor = #r31 editor
scoreboard players operation #uz editor *= #sx editor
scoreboard players operation #t1 editor = #r32 editor
scoreboard players operation #t1 editor *= #sy editor
scoreboard players operation #uz editor += #t1 editor
scoreboard players operation #t1 editor = #r33 editor
scoreboard players operation #t1 editor *= #sz editor
scoreboard players operation #uz editor += #t1 editor
scoreboard players operation #uz editor /= 10000 const
$execute if score #mirror_s editor matches 1 run execute store result storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].start_pos[0] double 0.01 run scoreboard players get #ux editor
$execute if score #mirror_s editor matches 1 run execute store result storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].start_pos[1] double 0.01 run scoreboard players get #uy editor
$execute if score #mirror_s editor matches 1 run execute store result storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].start_pos[2] double 0.01 run scoreboard players get #uz editor
