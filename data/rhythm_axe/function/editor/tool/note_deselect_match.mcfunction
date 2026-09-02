# @s = 音符交互实体；匹配 interaction.player 与玩家 UUID（教程 interaction_ 写法）
data remove storage rhythm_axe:prop deselect_uuid_in_entity
data modify storage rhythm_axe:prop deselect_uuid_in_entity set from entity @s interaction.player
execute store success score #deselect_uuid_match editor run data modify storage rhythm_axe:prop deselect_uuid_in_entity set from storage rhythm_axe:prop deselect_player_uuid
execute if score #deselect_uuid_match editor matches 0 run execute if score debug_output options matches 1.. run tellraw @a[tag=editor_active] [{"text":"[调试.lv1][右键]","color":"gray"},{"text":" 匹配到音符","color":"green"}]
execute if score #deselect_uuid_match editor matches 0 run function rhythm_axe:editor/tool/note_deselect_exec
scoreboard players reset #deselect_uuid_match editor
