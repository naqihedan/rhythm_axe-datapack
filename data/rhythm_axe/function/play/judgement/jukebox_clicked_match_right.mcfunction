# @s = 唱片机交互实体；匹配 interaction.player 与玩家 UUID（右键）→ 命中打 interacted
# 照编辑器 note_deselect_match 的做法：把交互实体的 interaction.player 拷到临时槽，
# 再"set from 玩家 UUID"——data modify 在结果值==当前值（即相等）时返回 success 0（无变化），
# 据此判定相等即命中；不相等则返回 1 不命中。
data remove storage rhythm_axe:runtime jb_uid_in_entity
data modify storage rhythm_axe:runtime jb_uid_in_entity set from entity @s interaction.player
execute store success score #jb_uuid_match play_state run data modify storage rhythm_axe:runtime jb_uid_in_entity set from storage rhythm_axe:runtime jb_uuid
execute if score #jb_uuid_match play_state matches 0 run scoreboard players add @s interacted 1
scoreboard players reset #jb_uuid_match play_state
