# 左键点击交互实体（advancement reward，@s = 玩家）
# 照编辑器 note_click 模式：捕获玩家 UUID，遍历唱片机交互实体按 attack.player 匹配
#   （advancement player_hurt_entity 触发后，被点交互实体的 attack.player 即玩家 UUID，据此定位被击中的那个。）
advancement revoke @s only rhythm_axe:jukebox_left_click
data modify storage rhythm_axe:runtime jb_uuid set from entity @s UUID
execute as @e[type=interaction,tag=note_jukebox] run function rhythm_axe:play/judgement/jukebox_clicked_match_left
data remove storage rhythm_axe:runtime jb_uuid
