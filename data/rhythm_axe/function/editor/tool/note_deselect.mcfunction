# 音符交互实体右击奖励（advancement reward，@s = 玩家；按教程 interaction 模式）
advancement revoke @s only rhythm_axe:editor/note_deselect
execute if score debug_output options matches 1.. run tellraw @s [{"text":"[调试.lv1][右键]","color":"gray"},{"text":" 奖励函数已触发","color":"green"}]
execute unless entity @s[tag=editor_active] run execute if score debug_output options matches 1.. run tellraw @s [{"text":"[调试.lv1][右键]","color":"gray"},{"text":" 非 editor_active","color":"red"}]
execute unless entity @s[tag=editor_active] run return fail
# 捕获玩家 UUID
data modify storage rhythm_axe:prop deselect_player_uuid set from entity @s UUID
execute if score debug_output options matches 1.. run tellraw @s [{"text":"[调试.lv1][右键]","color":"gray"},{"text":" 已捕获玩家UUID，遍历交互实体","color":"green"}]
# 遍历音符交互实体，按 interaction.player 匹配（匹配到的那个即被右击的）
execute as @e[type=interaction,tag=editor_note] run function rhythm_axe:editor/tool/note_deselect_match
execute if score debug_output options matches 1.. run tellraw @s [{"text":"[调试.lv1][右键]","color":"gray"},{"text":" 遍历结束","color":"green"}]
data remove storage rhythm_axe:prop deselect_player_uuid
