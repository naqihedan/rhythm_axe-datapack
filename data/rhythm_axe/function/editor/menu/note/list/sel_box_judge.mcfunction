#arg:cursor,i,nid,minx,maxx,miny,maxy,minz,maxz
# 框选判定叶子（宏，不递归）：音符若存活（有交互实体）且其交互实体判定中心在选区内 → 追加 {id,idx} + 打 tag + 高亮
# 实体不存在（非存活/已消失）→ return 0 跳过该音符
$execute unless entity @e[tag=editor_n_$(nid),type=interaction] run return 0
scoreboard players set #bhint editor 0
$execute as @e[tag=editor_n_$(nid),type=interaction] run execute store result score #bpx editor run data get entity @s Pos[0]
$execute as @e[tag=editor_n_$(nid),type=interaction] run execute store result score #bpy editor run data get entity @s Pos[1]
$execute as @e[tag=editor_n_$(nid),type=interaction] run execute store result score #bpz editor run data get entity @s Pos[2]
$execute as @e[tag=editor_n_$(nid),type=interaction] run execute store result score #bhalf editor run data get entity @s width 1000
$execute as @e[tag=editor_n_$(nid),type=interaction] run scoreboard players operation #bhalf editor /= 1000 const
$execute as @e[tag=editor_n_$(nid),type=interaction] run scoreboard players operation #bhalf editor /= 2 const
$execute as @e[tag=editor_n_$(nid),type=interaction] run scoreboard players operation #bpy editor += #bhalf editor
$execute if score #bpx editor matches $(minx)..$(maxx) if score #bpy editor matches $(miny)..$(maxy) if score #bpz editor matches $(minz)..$(maxz) run scoreboard players set #bhint editor 1
$execute if score #bhint editor matches 1 run data modify storage rhythm_axe:maps.editor selection append value {id:$(nid),idx:$(i)}
$execute if score #bhint editor matches 1 run execute as @e[type=interaction,tag=editor_n_$(nid)] run tag @s add editor_note_selected
$execute if score #bhint editor matches 1 run execute as @e[tag=editor_n_$(nid),type=item_display] run data modify entity @s Glowing set value 1b
$execute if score #bhint editor matches 1 run execute as @e[tag=editor_n_$(nid),type=item_display] run data modify entity @s glow_color_override set value 16776960
