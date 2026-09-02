advancement revoke @s only rhythm_axe:editor/note_click
execute if score debug_output options matches 1.. run tellraw @s [{"text":"[调试.lv1][左键]","color":"gray"},{"text":" 奖励函数已触发","color":"green"}]
execute unless entity @s[tag=editor_active] run execute if score debug_output options matches 1.. run tellraw @s [{"text":"[调试.lv1][左键]","color":"gray"},{"text":" 非 editor_active","color":"red"}]
execute unless entity @s[tag=editor_active] run return fail
# 判定位置偏移模式：Shift+左键 且 暂停（playing==0）→ #click_offset_mode=1
scoreboard players set #click_offset_mode editor 0
execute if entity @s[predicate=rhythm_axe:sneaking] if data storage rhythm_axe:maps.editor {playing:0b} run scoreboard players set #click_offset_mode editor 1
execute if score debug_output options matches 1.. run tellraw @s [{"text":"[调试.lv1][左键]","color":"gray"},{"text":" 偏移模式=","color":"gold"},{"score":{"name":"#click_offset_mode","objective":"editor"},"color":"aqua"}]
# 左键（player_hurt_entity 攻击）：攻击不写 interaction.player，但会写 attack.player，
# 据此做 UUID 匹配，与右键（interaction.player）同套模式
data modify storage rhythm_axe:prop click_player_uuid set from entity @s UUID
execute if score debug_output options matches 1.. run tellraw @s [{"text":"[调试.lv1][左键]","color":"gray"},{"text":" 已捕获玩家UUID，遍历交互实体","color":"green"}]
execute as @e[type=interaction,tag=editor_note] run function rhythm_axe:editor/tool/note_click_match
execute if score debug_output options matches 1.. run tellraw @s [{"text":"[调试.lv1][左键]","color":"gray"},{"text":" 遍历结束","color":"green"}]
data remove storage rhythm_axe:prop click_player_uuid
