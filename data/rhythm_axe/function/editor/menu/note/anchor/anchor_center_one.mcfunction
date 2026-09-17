#arg:cursor,index
# 锚点中心扫描单音符（宏叶子）：读 notes[$(index)].position[0..2]（×100 定点）更新 #ac_min0..2 / #ac_max0..2
$execute store result score #ac_v editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].position[0] 100
execute if score #ac_v editor < #ac_min0 editor run scoreboard players operation #ac_min0 editor = #ac_v editor
execute if score #ac_v editor > #ac_max0 editor run scoreboard players operation #ac_max0 editor = #ac_v editor
$execute store result score #ac_v editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].position[1] 100
execute if score #ac_v editor < #ac_min1 editor run scoreboard players operation #ac_min1 editor = #ac_v editor
execute if score #ac_v editor > #ac_max1 editor run scoreboard players operation #ac_max1 editor = #ac_v editor
$execute store result score #ac_v editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].position[2] 100
execute if score #ac_v editor < #ac_min2 editor run scoreboard players operation #ac_min2 editor = #ac_v editor
execute if score #ac_v editor > #ac_max2 editor run scoreboard players operation #ac_max2 editor = #ac_v editor
