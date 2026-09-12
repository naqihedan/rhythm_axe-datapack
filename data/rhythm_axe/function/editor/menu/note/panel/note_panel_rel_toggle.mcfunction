# 音符面板相对/绝对开关：#rel_field = 1时间 / 2大小 / 3位置 / 4起始位置 / 5持续时长
# 翻转对应 editing.rel.on.<field>，并把该字段相对增量清零，然后重渲面板。
# 说明：editing.rel.delta.<field> 为标量（时间/大小）或 {x,y,z} 复合（位置/起始位置）。
scoreboard players set #rel_was editor 0
# 时间
execute if score #rel_field editor matches 1 run execute store result score #rel_was editor run data get storage rhythm_axe:maps.editor editing.rel.on.time
execute if score #rel_field editor matches 1 if score #rel_was editor matches 0 run data modify storage rhythm_axe:maps.editor editing.rel.on.time set value 1b
execute if score #rel_field editor matches 1 if score #rel_was editor matches 1 run data modify storage rhythm_axe:maps.editor editing.rel.on.time set value 0b
execute if score #rel_field editor matches 1 if score #rel_was editor matches 0 run data modify storage rhythm_axe:maps.editor editing.rel.delta.time set value 0
# 大小
execute if score #rel_field editor matches 2 run execute store result score #rel_was editor run data get storage rhythm_axe:maps.editor editing.rel.on.size
execute if score #rel_field editor matches 2 if score #rel_was editor matches 0 run data modify storage rhythm_axe:maps.editor editing.rel.on.size set value 1b
execute if score #rel_field editor matches 2 if score #rel_was editor matches 1 run data modify storage rhythm_axe:maps.editor editing.rel.on.size set value 0b
execute if score #rel_field editor matches 2 if score #rel_was editor matches 0 run data modify storage rhythm_axe:maps.editor editing.rel.delta.size set value 0
# 位置
execute if score #rel_field editor matches 3 run execute store result score #rel_was editor run data get storage rhythm_axe:maps.editor editing.rel.on.position
execute if score #rel_field editor matches 3 if score #rel_was editor matches 0 run data modify storage rhythm_axe:maps.editor editing.rel.on.position set value 1b
execute if score #rel_field editor matches 3 if score #rel_was editor matches 1 run data modify storage rhythm_axe:maps.editor editing.rel.on.position set value 0b
execute if score #rel_field editor matches 3 if score #rel_was editor matches 0 run data modify storage rhythm_axe:maps.editor editing.rel.delta.position set value [0,0,0]
# 起始位置
execute if score #rel_field editor matches 4 run execute store result score #rel_was editor run data get storage rhythm_axe:maps.editor editing.rel.on.start_pos
execute if score #rel_field editor matches 4 if score #rel_was editor matches 0 run data modify storage rhythm_axe:maps.editor editing.rel.on.start_pos set value 1b
execute if score #rel_field editor matches 4 if score #rel_was editor matches 1 run data modify storage rhythm_axe:maps.editor editing.rel.on.start_pos set value 0b
execute if score #rel_field editor matches 4 if score #rel_was editor matches 0 run data modify storage rhythm_axe:maps.editor editing.rel.delta.start_pos set value [0,0,0]
# 持续时长
scoreboard players set #rel_was editor 0
execute if score #rel_field editor matches 5 run execute store result score #rel_was editor run data get storage rhythm_axe:maps.editor editing.rel.on.duration
execute if score #rel_field editor matches 5 if score #rel_was editor matches 0 run data modify storage rhythm_axe:maps.editor editing.rel.on.duration set value 1b
execute if score #rel_field editor matches 5 if score #rel_was editor matches 1 run data modify storage rhythm_axe:maps.editor editing.rel.on.duration set value 0b
execute if score #rel_field editor matches 5 if score #rel_was editor matches 0 run data modify storage rhythm_axe:maps.editor editing.rel.delta.duration set value 0
function rhythm_axe:editor/menu/note/panel/note_panel
