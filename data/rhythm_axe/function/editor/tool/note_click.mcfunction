advancement revoke @s only rhythm_axe:editor/note_click
execute if score debug_output options matches 1.. run tellraw @s [{"text":"[调试.lv1][左键]","color":"gray"},{"text":" 奖励函数已触发","color":"green"}]
execute unless entity @s[tag=editor_active] run execute if score debug_output options matches 1.. run tellraw @s [{"text":"[调试.lv1][左键]","color":"gray"},{"text":" 非 editor_active","color":"red"}]
execute unless entity @s[tag=editor_active] run return fail
# 协作：记住「这次左键是谁点的」。后续以音符交互实体身份执行（@s 不是玩家），
#   不能再 `as @a[tag=editor_active]` 对所有成员各跑一遍（会重复选中 / 重复渲染）。
tag @a[tag=editor_actor] remove editor_actor
tag @s add editor_actor
# ★ 真实判定（试听）：播放中 + 判定模式 → 左键转交判定输入（不进入选中/开面板流程）
#   （判定输入只在唱片机上有效；其他类型点击被忽略，见 judge/input_click）
execute if score editor_note_judge options matches 1 if data storage rhythm_axe:maps.editor {playing:1b} run function rhythm_axe:editor/judge/input_click
execute if score editor_note_judge options matches 1 if data storage rhythm_axe:maps.editor {playing:1b} run return fail
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
