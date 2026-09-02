# 匹配该交互实体是否由点击玩家交互（@s = 音符交互实体；按图示 UUID 匹配写法）
# 匹配到（data modify 从 click_player 覆盖失败，即被点实体 interaction.player 与玩家 UUID 一致）→ note_click_do_
data remove storage rhythm_axe:maps.editor click_uuid
data modify storage rhythm_axe:maps.editor click_uuid set from entity @s interaction.player
execute store success score #UUID_match editor run data modify storage rhythm_axe:maps.editor click_uuid set from storage rhythm_axe:maps.editor click_player
execute if score #UUID_match editor matches 0 run function rhythm_axe:editor/tool/note_click_do_
scoreboard players reset #UUID_match editor
