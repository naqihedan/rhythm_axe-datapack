#arg:gid
# 音符工具注视光标（黄色玻璃）：协作版「每人一块」，身份 tag = glow_$(gid)（gid = 玩家 UUID[0]，见 cursor_tick）
# ★ 单人时代是「全局一块」：多人同时手持会互相 tp 同一块玻璃（每刻在两个光标之间跳 = 闪烁）；
#   而且「没手持工具就 kill 全部」会把别人的光标一起删掉（表现为「自己看不见黄色玻璃」）。
#   ⇒ 按身份各管各的。清理由 tick.mcfunction 的存活标记统一负责（本刻没被认领的玻璃会被杀），
#      所以本文件不需要 kill —— 没手持 / 下线 / 被踢 都会自动不认领。
$execute if data entity @s SelectedItem.components."minecraft:custom_data".editor_tool_note unless entity @e[tag=glow_$(gid)] run summon item_display ~ ~ ~ {item:{id:"minecraft:yellow_stained_glass",count:1},Tags:["editor_tool_glow","glow_$(gid)"],Glowing:1b,glow_color_override:16776960,brightness:{block:15,sky:15},transformation:{translation:[0f,0f,0f],left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],scale:[1.01f,1.01f,1.01f]}}
$execute if data entity @s SelectedItem.components."minecraft:custom_data".editor_tool_note run tag @e[tag=glow_$(gid)] add glow_alive
$execute if data entity @s SelectedItem.components."minecraft:custom_data".editor_tool_note anchored eyes positioned ^ ^ ^4 align xyz positioned ~0.5 ~0.5 ~0.5 run tp @e[tag=glow_$(gid)] ~ ~ ~
