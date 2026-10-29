#arg:gid
# 音符工具注视光标（黄色玻璃）：协作版「每人一块」，身份 tag = glow_$(gid)（gid = 玩家 UUID[0]，见 cursor_tick）
# ★ 单人时代是「全局一块」：多人同时手持会互相 tp 同一块玻璃（每刻在两个光标之间跳 = 闪烁）；
#   而且「没手持工具就 kill 全部」会把别人的光标一起删掉（表现为「自己看不见黄色玻璃」）。
#   ⇒ 按身份各管各的。清理由 tick.mcfunction 的存活标记统一负责（本刻没被认领的玻璃会被杀），
#      所以本文件不需要 kill —— 没手持 / 下线 / 被踢 都会自动不认领。
$execute if data entity @s SelectedItem.components."minecraft:custom_data".editor_tool_note unless entity @e[tag=glow_$(gid)] run summon item_display ~ ~-1 ~ {item:{id:"minecraft:yellow_stained_glass",count:1},Tags:["editor_tool_glow","glow_$(gid)"],Glowing:1b,glow_color_override:16776960,brightness:{block:15,sky:15},transformation:{translation:[0f,1f,0f],left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],scale:[1.01f,1.01f,1.01f]}}
$execute if data entity @s SelectedItem.components."minecraft:custom_data".editor_tool_note run tag @e[tag=glow_$(gid)] add glow_alive
# ★ 2026-10-29：实体 Pos 比视觉位置低 1 格（translation:[0,1,0] 补偿）—— 防止点到 Axiom 的展示实体小工具（它按实体 Pos 选实体）
#   注意：
#   · 下面所有「直接写 Pos[i]」的地方，Y 轴必须再减 100（×100 口径）/ 1000（×1000 口径）
#   · 「读 Pos → 吸附 → 写回」的地方不用改（网格 1 格 = 1.000 正好是四档的整数倍，吸附对 ±1 平移不变）
$execute if data entity @s SelectedItem.components."minecraft:custom_data".editor_tool_note anchored eyes positioned ^ ^ ^4 run tp @e[tag=glow_$(gid)] ~ ~-1 ~
execute if data entity @s SelectedItem.components."minecraft:custom_data".editor_tool_note run function rhythm_axe:editor/tool/glow_note_snap with storage rhythm_axe:prop
# 坐标锁定（面板 23）：光标也跟着锁定的轴走 —— 否则锁了 X 却看见光标在原地，会以为没生效
#   ★ 锁定在吸附之后（锁定是显式指定值，优先级更高）；值存 ×100（0.05 精度）
#   ★ Y 轴要减 100（= 1.00 格）：实体 Pos 比视觉位置低 1 格（见上方 translation 注释）
$execute if score note_lock_x tool_opt matches 1 run execute store result entity @e[tag=glow_$(gid),limit=1] Pos[0] double 0.01 run scoreboard players get note_lock_x_val tool_opt
execute if score note_lock_y tool_opt matches 1 run execute store result score #glow_ly editor run scoreboard players get note_lock_y_val tool_opt
execute if score note_lock_y tool_opt matches 1 run scoreboard players remove #glow_ly editor 100
$execute if score note_lock_y tool_opt matches 1 run execute store result entity @e[tag=glow_$(gid),limit=1] Pos[1] double 0.01 run scoreboard players get #glow_ly editor
scoreboard players reset #glow_ly editor
$execute if score note_lock_z tool_opt matches 1 run execute store result entity @e[tag=glow_$(gid),limit=1] Pos[2] double 0.01 run scoreboard players get note_lock_z_val tool_opt
