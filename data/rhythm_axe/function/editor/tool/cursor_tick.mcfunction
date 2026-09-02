
# ===== 音符工具注视光标（黄色玻璃）=====
execute unless data entity @s SelectedItem.components."minecraft:custom_data".editor_tool_note run kill @e[tag=editor_tool_glow]
execute if data entity @s SelectedItem.components."minecraft:custom_data".editor_tool_note \
        unless entity @e[tag=editor_tool_glow] run \
            summon item_display ~ ~ ~ {item:{id:"minecraft:yellow_stained_glass",count:1},Tags:["editor_tool_glow"],Glowing:1b,glow_color_override:16776960,brightness:{block:15,sky:15},transformation:{translation:[0f,0f,0f],left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],scale:[1.01f,1.01f,1.01f]}}
execute if data entity @s SelectedItem.components."minecraft:custom_data".editor_tool_note \
        anchored eyes positioned ^ ^ ^4 align xyz positioned ~0.5 ~0.5 ~0.5 run tp @e[tag=editor_tool_glow] ~ ~ ~
# ===== 选择工具注视/选区玻璃（黄绿色玻璃，发绿光）=====
# 未手持选择工具：清玻璃（确认选区后玻璃已被 select 逻辑 kill，此处仅兜底）
execute unless data entity @s SelectedItem.components."minecraft:custom_data".editor_tool_select run kill @e[tag=editor_tool_select_glow]
execute if data entity @s SelectedItem.components."minecraft:custom_data".editor_tool_select run function rhythm_axe:editor/tool/select/select_glow_tick