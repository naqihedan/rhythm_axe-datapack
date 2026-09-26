#arg:gid
# 选择工具注视/选区玻璃每 tick 更新（@s = 手持选择工具的编辑玩家）
# 协作：每人一块，身份 tag = glow_sel_$(gid)（gid = 玩家 UUID[0]，见 cursor_tick）
# state=0：小方块跟随注视位置（黄绿色发光玻璃）；state=1：从第一角拉伸到当前注视位置（动态预览选区）
# 清理同样交给 tick.mcfunction 的存活标记：没手持 / 蹲下 / 被踢 / 下线 ⇒ 本刻不认领 ⇒ 被杀
execute store result score #sel_state editor run data get storage rhythm_axe:maps.editor select_tool.state
# 若 select_tool 未初始化（尚未右击过）→ 视为 state=0（玻璃跟随注视）
execute unless data storage rhythm_axe:maps.editor select_tool run scoreboard players set #sel_state editor 0
# 规范化：残留 state=2 → 0
execute if score #sel_state editor matches 2.. run scoreboard players set #sel_state editor 0
# 蹲下（时间段选择模式）：不显示玻璃预览（该模式只用 mod 时间轴上的入点/出点与范围色带）
execute if entity @s[predicate=rhythm_axe:sneaking] run return 0
$execute unless entity @e[tag=glow_sel_$(gid)] run summon item_display ~ ~ ~ {item:{id:"minecraft:lime_stained_glass",count:1},Tags:["editor_tool_select_glow","glow_sel_$(gid)"],Glowing:1b,glow_color_override:65280,brightness:{block:15,sky:15},transformation:{translation:[0f,0f,0f],left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],scale:[1f,1f,1f]}}
$tag @e[tag=glow_sel_$(gid)] add glow_alive
# state=0：小方块跟随注视位置
$execute if score #sel_state editor matches 0 anchored eyes positioned ^ ^ ^4 align xyz positioned ~0.5 ~0.5 ~0.5 run tp @e[tag=glow_sel_$(gid)] ~ ~ ~
$execute if score #sel_state editor matches 0 run data modify entity @e[tag=glow_sel_$(gid),limit=1] transformation.scale set value [1.02f,1.02f,1.02f]
# state=1：从第一角拉伸到当前注视（select_stretch 宏按 $(glow_sel) 认玻璃）
$execute if score #sel_state editor matches 1 run function rhythm_axe:editor/tool/select/select_stretch_prep {glow_sel:"glow_sel_$(gid)"}
