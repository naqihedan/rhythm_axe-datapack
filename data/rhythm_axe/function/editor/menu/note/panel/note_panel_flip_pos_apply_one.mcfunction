#arg:cursor,index,flip_axis
# 判定位置轴镜像应用单个音符（宏叶子）：position[$(flip_axis)] = 2×锚点 − old（原位写回，不重排）
# ★ 2026-09-17：锚点 = #rc0/#rc1/#rc2（×100）；不再用 min/max（锚点不存在时 #rc* 已由 anchor_get 填成包围盒中心）
$execute store result score #p_val editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].position[$(flip_axis)] 100
# 取锚点在 $(flip_axis) 轴上的值（宏叶子内不能动态拼计分项名 → 按轴三分支；首行无条件赋值，无需先清零）
scoreboard players operation #p_anc editor = #rc0 editor
execute if score #flip_axis editor matches 1 run scoreboard players operation #p_anc editor = #rc1 editor
execute if score #flip_axis editor matches 2 run scoreboard players operation #p_anc editor = #rc2 editor
scoreboard players operation #p_new editor = #p_anc editor
scoreboard players operation #p_new editor *= 2 const
scoreboard players operation #p_new editor -= #p_val editor
$execute store result storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].position[$(flip_axis)] double 0.01 run scoreboard players get #p_new editor
