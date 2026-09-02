# 判定位置 = 玩家所在方块中心（floor(Pos)+0.5；【对齐方块中心】）
# 正数区：score=int 截断 = floor；(2*floor+1)*0.5 = floor+0.5
execute store result score #px editor run data get entity @s Pos[0]
execute store result score #py editor run data get entity @s Pos[1]
execute store result score #pz editor run data get entity @s Pos[2]
scoreboard players operation #px2 editor = #px editor
scoreboard players operation #px2 editor *= 2 const
scoreboard players add #px2 editor 1
execute store result storage rhythm_axe:maps.editor editing.temp.position[0] double 0.5 run scoreboard players get #px2 editor
scoreboard players operation #py2 editor = #py editor
scoreboard players operation #py2 editor *= 2 const
scoreboard players add #py2 editor 1
execute store result storage rhythm_axe:maps.editor editing.temp.position[1] double 0.5 run scoreboard players get #py2 editor
scoreboard players operation #pz2 editor = #pz editor
scoreboard players operation #pz2 editor *= 2 const
scoreboard players add #pz2 editor 1
execute store result storage rhythm_axe:maps.editor editing.temp.position[2] double 0.5 run scoreboard players get #pz2 editor
data modify storage rhythm_axe:maps.editor feedback set value "判定位置已对齐方块中心（确认后生效）"
data modify storage rhythm_axe:maps.editor no_undo set value 1b
function rhythm_axe:editor/menu/note/panel/note_panel
