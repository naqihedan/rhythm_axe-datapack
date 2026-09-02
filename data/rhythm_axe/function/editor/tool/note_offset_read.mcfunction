# 读交互实体实际位置与"应该在的位置"，算偏移（@s = 音符交互实体；×1000）
# 输出： #off_x / #off_y / #off_z = 实际 - 应该（×1000）；#off_valid = 1 表示计算成功；#nc_id = 音符 id
scoreboard players set #off_valid editor 0
execute if data entity @s data.editor_should_x if data entity @s data.editor_should_y if data entity @s data.editor_should_z run scoreboard players set #off_valid editor 1
execute if score #off_valid editor matches 1 run execute store result score #off_actx editor run data get entity @s Pos[0] 1000
execute if score #off_valid editor matches 1 run execute store result score #off_acty editor run data get entity @s Pos[1] 1000
execute if score #off_valid editor matches 1 run execute store result score #off_actz editor run data get entity @s Pos[2] 1000
execute if score #off_valid editor matches 1 run execute store result score #off_shdx editor run data get entity @s data.editor_should_x 1000
execute if score #off_valid editor matches 1 run execute store result score #off_shdy editor run data get entity @s data.editor_should_y 1000
execute if score #off_valid editor matches 1 run execute store result score #off_shdz editor run data get entity @s data.editor_should_z 1000
# 偏移 = 实际 - 应该
scoreboard players operation #off_x editor = #off_actx editor
scoreboard players operation #off_x editor -= #off_shdx editor
scoreboard players operation #off_y editor = #off_acty editor
scoreboard players operation #off_y editor -= #off_shdy editor
scoreboard players operation #off_z editor = #off_actz editor
scoreboard players operation #off_z editor -= #off_shdz editor
# 记录音符 id
execute store result score #nc_id editor run scoreboard players get @s note_id
# 调试：确认为什么读不到偏移
execute if score debug_output options matches 1.. run tellraw @a[tag=editor_active] [{"text":"[调试.lv1][偏移]","color":"gray"},{"text":" nid=","color":"gold"},{"score":{"name":"@s","objective":"note_id"},"color":"aqua"},{"text":" 有效=","color":"gold"},{"score":{"name":"#off_valid","objective":"editor"},"color":"aqua"},{"text":" placed=","color":"gold"},{"nbt":"data.editor_placed","entity":"@s","color":"aqua"},{"text":" 应x=","color":"gray"},{"nbt":"data.editor_should_x","entity":"@s","color":"white"},{"text":" 实x=","color":"gray"},{"nbt":"Pos[0]","entity":"@s","color":"white"},{"text":" 漂移x=","color":"gray"},{"score":{"name":"#off_x","objective":"editor"},"color":"aqua"}]
