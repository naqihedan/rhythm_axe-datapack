# 选择工具注视/选区玻璃每 tick 更新（@s = 编辑玩家，已手持选择工具 editor_tool_select）
# state=0：小方块跟随注视位置（黄绿色发光玻璃，同音符工具黄色光标）
# state=1：从第一角拉伸到当前注视位置（动态预览选区）
# （两态循环：选角1 → 选角2确认弹面板后回选角1；无取消态）
execute store result score #sel_state editor run data get storage rhythm_axe:maps.editor select_tool.state
# 若 select_tool 未初始化（尚未右击过）→ 视为 state=0（玻璃跟随注视）
execute unless data storage rhythm_axe:maps.editor select_tool run scoreboard players set #sel_state editor 0
# 规范化：残留 state=2 → 0
execute if score #sel_state editor matches 2.. run scoreboard players set #sel_state editor 0
execute unless entity @e[tag=editor_tool_select_glow] run summon item_display ~ ~ ~ {item:{id:"minecraft:lime_stained_glass",count:1},Tags:["editor_tool_select_glow"],Glowing:1b,glow_color_override:65280,brightness:{block:15,sky:15},transformation:{translation:[0f,0f,0f],left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],scale:[1f,1f,1f]}}
# state=0：小方块跟随注视位置
execute if score #sel_state editor matches 0 run execute anchored eyes positioned ^ ^ ^4 align xyz positioned ~0.5 ~0.5 ~0.5 run tp @e[tag=editor_tool_select_glow] ~ ~ ~
execute if score #sel_state editor matches 0 run data modify entity @e[tag=editor_tool_select_glow,limit=1] transformation.scale set value [1.02f,1.02f,1.02f]
# state=1：从第一角拉伸到当前注视
execute if score #sel_state editor matches 1 run function rhythm_axe:editor/tool/select/select_stretch_prep
