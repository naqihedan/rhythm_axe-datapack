# 右键点击交互实体（advancement reward，@s = 玩家）
# 照编辑器 note_deselect 模式：捕获玩家 UUID，遍历唱片机交互实体按 interaction.player 匹配
#   （advancement player_interacted_with_entity 触发后，被点交互实体的 interaction.player 即玩家 UUID，
#   据此定位被击中的那个。）
advancement revoke @s only rhythm_axe:jukebox_right_click
data modify storage rhythm_axe:runtime jb_uuid set from entity @s UUID
execute as @e[type=interaction,tag=note_jukebox] run function rhythm_axe:play/judgement/jukebox_clicked_match_right
data remove storage rhythm_axe:runtime jb_uuid
