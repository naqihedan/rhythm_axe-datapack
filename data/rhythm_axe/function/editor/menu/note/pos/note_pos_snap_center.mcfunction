# 判定位置对齐方块中心：把面板"判定位置"当前坐标对齐到方块中心 floor(x)+0.5（与玩家位置无关）
#   绝对（rel.on.position=0）：editing.temp.position[i]；相对（=1）：editing.rel.delta.position[i]（×100 整数）
#   统一算法：floor(x)+0.5 → 相对用 ×100 整数（x/100*100+50），绝对用 data get *100 取 floor(×100)/100+0.5
scoreboard players set #relp editor 0
execute store result score #relp editor run data get storage rhythm_axe:maps.editor editing.rel.on.position
# 相对：增量对齐（×100 整数；floor(delta/100)*100 + 50）
execute if score #relp editor matches 1 run execute store result score #p editor run data get storage rhythm_axe:maps.editor editing.rel.delta.position[0]
execute if score #relp editor matches 1 run scoreboard players operation #p editor /= 100 const
execute if score #relp editor matches 1 run scoreboard players operation #p editor *= 100 const
execute if score #relp editor matches 1 run scoreboard players add #p editor 50
execute if score #relp editor matches 1 run execute store result storage rhythm_axe:maps.editor editing.rel.delta.position[0] int 1 run scoreboard players get #p editor
execute if score #relp editor matches 1 run execute store result score #p editor run data get storage rhythm_axe:maps.editor editing.rel.delta.position[1]
execute if score #relp editor matches 1 run scoreboard players operation #p editor /= 100 const
execute if score #relp editor matches 1 run scoreboard players operation #p editor *= 100 const
execute if score #relp editor matches 1 run scoreboard players add #p editor 50
execute if score #relp editor matches 1 run execute store result storage rhythm_axe:maps.editor editing.rel.delta.position[1] int 1 run scoreboard players get #p editor
execute if score #relp editor matches 1 run execute store result score #p editor run data get storage rhythm_axe:maps.editor editing.rel.delta.position[2]
execute if score #relp editor matches 1 run scoreboard players operation #p editor /= 100 const
execute if score #relp editor matches 1 run scoreboard players operation #p editor *= 100 const
execute if score #relp editor matches 1 run scoreboard players add #p editor 50
execute if score #relp editor matches 1 run execute store result storage rhythm_axe:maps.editor editing.rel.delta.position[2] int 1 run scoreboard players get #p editor
# 绝对：editing.temp.position[i] → floor(x)+0.5（data get *100 取 floor(×100)，再 /100*100+50，存回 double 0.01）
execute unless score #relp editor matches 1 run execute store result score #p editor run data get storage rhythm_axe:maps.editor editing.temp.position[0] 100
execute unless score #relp editor matches 1 run scoreboard players operation #p editor /= 100 const
execute unless score #relp editor matches 1 run scoreboard players operation #p editor *= 100 const
execute unless score #relp editor matches 1 run scoreboard players add #p editor 50
execute unless score #relp editor matches 1 run execute store result storage rhythm_axe:maps.editor editing.temp.position[0] double 0.01 run scoreboard players get #p editor
execute unless score #relp editor matches 1 run execute store result score #p editor run data get storage rhythm_axe:maps.editor editing.temp.position[1] 100
execute unless score #relp editor matches 1 run scoreboard players operation #p editor /= 100 const
execute unless score #relp editor matches 1 run scoreboard players operation #p editor *= 100 const
execute unless score #relp editor matches 1 run scoreboard players add #p editor 50
execute unless score #relp editor matches 1 run execute store result storage rhythm_axe:maps.editor editing.temp.position[1] double 0.01 run scoreboard players get #p editor
execute unless score #relp editor matches 1 run execute store result score #p editor run data get storage rhythm_axe:maps.editor editing.temp.position[2] 100
execute unless score #relp editor matches 1 run scoreboard players operation #p editor /= 100 const
execute unless score #relp editor matches 1 run scoreboard players operation #p editor *= 100 const
execute unless score #relp editor matches 1 run scoreboard players add #p editor 50
execute unless score #relp editor matches 1 run execute store result storage rhythm_axe:maps.editor editing.temp.position[2] double 0.01 run scoreboard players get #p editor
data modify storage rhythm_axe:maps.editor no_undo set value 1b
function rhythm_axe:editor/menu/note/panel/note_panel
