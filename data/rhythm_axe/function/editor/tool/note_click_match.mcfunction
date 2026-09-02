# @s = 音符交互实体；匹配 attack.player 与玩家 UUID（左键攻击写 attack.player）
data remove storage rhythm_axe:prop click_uuid_in_entity
data modify storage rhythm_axe:prop click_uuid_in_entity set from entity @s attack.player
execute store success score #click_uuid_match editor run data modify storage rhythm_axe:prop click_uuid_in_entity set from storage rhythm_axe:prop click_player_uuid
execute if score #click_uuid_match editor matches 0 run execute if score debug_output options matches 1.. run tellraw @a[tag=editor_active] [{"text":"[调试.lv1][左键]","color":"gray"},{"text":" 匹配到音符","color":"green"}]
execute if score #click_uuid_match editor matches 0 run function rhythm_axe:editor/tool/note_click_exec
scoreboard players reset #click_uuid_match editor
