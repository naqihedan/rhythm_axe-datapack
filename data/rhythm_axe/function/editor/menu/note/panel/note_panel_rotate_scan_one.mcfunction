#arg:cursor,index
# 旋转扫描单个音符（宏叶子）：读 position[0/1/2]（×100），更新三轴包围盒 #rmin*/#rmax*
$execute store result score #rx editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].position[0] 100
$execute store result score #ry editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].position[1] 100
$execute store result score #rz editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].position[2] 100
execute if score #rx editor < #rmin0 editor run scoreboard players operation #rmin0 editor = #rx editor
execute if score #rx editor > #rmax0 editor run scoreboard players operation #rmax0 editor = #rx editor
execute if score #ry editor < #rmin1 editor run scoreboard players operation #rmin1 editor = #ry editor
execute if score #ry editor > #rmax1 editor run scoreboard players operation #rmax1 editor = #ry editor
execute if score #rz editor < #rmin2 editor run scoreboard players operation #rmin2 editor = #rz editor
execute if score #rz editor > #rmax2 editor run scoreboard players operation #rmax2 editor = #rz editor
