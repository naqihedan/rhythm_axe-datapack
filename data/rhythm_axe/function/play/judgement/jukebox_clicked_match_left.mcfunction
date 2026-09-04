# @s = 唱片机交互实体；匹配 attack.player 与玩家 UUID（左键攻击）→ 命中打 interacted
# 同 jukebox_clicked_match_right，但用 attack.player（左键攻击写该字段）。
data remove storage rhythm_axe:runtime jb_uid_in_entity
data modify storage rhythm_axe:runtime jb_uid_in_entity set from entity @s attack.player
execute store success score #jb_uuid_match play_state run data modify storage rhythm_axe:runtime jb_uid_in_entity set from storage rhythm_axe:runtime jb_uuid
execute if score #jb_uuid_match play_state matches 0 run scoreboard players add @s interacted 1
scoreboard players reset #jb_uuid_match play_state
