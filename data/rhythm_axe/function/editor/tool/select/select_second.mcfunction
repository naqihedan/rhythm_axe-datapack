# 确认选区：存 corner2（黄绿玻璃已拉伸到当前注视位置）；末尾回 state=0 + 弹已选定音符列表面板
data modify storage rhythm_axe:maps.editor select_tool.corner2 set value [0.0d,0.0d,0.0d]
data modify storage rhythm_axe:maps.editor select_tool.corner2[0] set from storage rhythm_axe:prop sx
data modify storage rhythm_axe:maps.editor select_tool.corner2[1] set from storage rhythm_axe:prop sy
data modify storage rhythm_axe:maps.editor select_tool.corner2[2] set from storage rhythm_axe:prop sz
tellraw @s [{"text":"[编辑器] 第二选取点已设为 ","color":"yellow"},{"nbt":"select_tool.corner2","storage":"rhythm_axe:maps.editor","color":"aqua"}]
# 读取两角方块坐标（store result 截断为整数方块坐标）
execute store result score #c1x editor run data get storage rhythm_axe:maps.editor select_tool.corner1[0]
execute store result score #c1y editor run data get storage rhythm_axe:maps.editor select_tool.corner1[1]
execute store result score #c1z editor run data get storage rhythm_axe:maps.editor select_tool.corner1[2]
execute store result score #c2x editor run data get storage rhythm_axe:maps.editor select_tool.corner2[0]
execute store result score #c2y editor run data get storage rhythm_axe:maps.editor select_tool.corner2[1]
execute store result score #c2z editor run data get storage rhythm_axe:maps.editor select_tool.corner2[2]
# min/max 各轴
scoreboard players operation #minx editor = #c1x editor
execute if score #c2x editor < #minx editor run scoreboard players operation #minx editor = #c2x editor
scoreboard players operation #maxx editor = #c1x editor
execute if score #c2x editor > #maxx editor run scoreboard players operation #maxx editor = #c2x editor
scoreboard players operation #miny editor = #c1y editor
execute if score #c2y editor < #miny editor run scoreboard players operation #miny editor = #c2y editor
scoreboard players operation #maxy editor = #c1y editor
execute if score #c2y editor > #maxy editor run scoreboard players operation #maxy editor = #c2y editor
scoreboard players operation #minz editor = #c1z editor
execute if score #c2z editor < #minz editor run scoreboard players operation #minz editor = #c2z editor
scoreboard players operation #maxz editor = #c1z editor
execute if score #c2z editor > #maxz editor run scoreboard players operation #maxz editor = #c2z editor
# 边长 n = max - min + 1（含两端方块）
scoreboard players operation #nx editor = #maxx editor
scoreboard players operation #nx editor -= #minx editor
scoreboard players add #nx editor 1
scoreboard players operation #ny editor = #maxy editor
scoreboard players operation #ny editor -= #miny editor
scoreboard players add #ny editor 1
scoreboard players operation #nz editor = #maxz editor
scoreboard players operation #nz editor -= #minz editor
scoreboard players add #nz editor 1
# 清空旧选中（selected 标记 + selection + 高亮 + tag）
function rhythm_axe:editor/menu/note/selected/sel_clear_all
scoreboard players set #sel_count editor 0
execute as @e[tag=editor_note,type=item_display] run data modify entity @s Glowing set value 0b
execute as @e[type=interaction,tag=editor_note] run tag @s remove editor_note_selected
# 存宏参 → select_highlight（判定+高亮+标记 selected）
data modify storage rhythm_axe:prop cursor set from storage rhythm_axe:maps.editor history_cursor
execute store result storage rhythm_axe:prop minx int 1 run scoreboard players get #minx editor
execute store result storage rhythm_axe:prop maxx int 1 run scoreboard players get #maxx editor
execute store result storage rhythm_axe:prop miny int 1 run scoreboard players get #miny editor
execute store result storage rhythm_axe:prop maxy int 1 run scoreboard players get #maxy editor
execute store result storage rhythm_axe:prop minz int 1 run scoreboard players get #minz editor
execute store result storage rhythm_axe:prop maxz int 1 run scoreboard players get #maxz editor
function rhythm_axe:editor/tool/select/select_highlight with storage rhythm_axe:prop
# 重建 selection（按 notes 顺序收集选中标记的音符）
function rhythm_axe:editor/menu/note/selected/sel_rebuild
# 清宏参
data remove storage rhythm_axe:prop cursor
data remove storage rhythm_axe:prop minx
data remove storage rhythm_axe:prop maxx
data remove storage rhythm_axe:prop miny
data remove storage rhythm_axe:prop maxy
data remove storage rhythm_axe:prop minz
data remove storage rhythm_axe:prop maxz
# 确认后：黄绿色玻璃使命完成，kill；状态回 0（下次右击重新选第一角）
kill @e[tag=editor_tool_select_glow]
data modify storage rhythm_axe:maps.editor select_tool.state set value 0
# ★ 临时调试：selection 内容 + 交互实体数
execute if score debug_output options matches 1.. run tellraw @s [{"text":"[调试.lv1][sel]","color":"gray"},{"text":" selection=","color":"gold"},{"nbt":"selection","storage":"rhythm_axe:maps.editor","color":"aqua"},{"text":" 命中数=","color":"gold"},{"score":{"name":"#sel_count","objective":"editor"},"color":"aqua"}]
scoreboard players set #n_inter editor 0
execute as @e[type=interaction,tag=editor_note] run scoreboard players add #n_inter editor 1
execute if score debug_output options matches 1.. run tellraw @s [{"text":"[调试.lv1][sel]","color":"gray"},{"text":" 交互实体数=","color":"gold"},{"score":{"name":"#n_inter","objective":"editor"},"color":"aqua"}]
execute as @e[type=interaction,tag=editor_note] run execute if score debug_output options matches 1.. run tellraw @s [{"text":"[调试.lv1][sel]","color":"gray"},{"text":" 交互 nid=","color":"gold"},{"score":{"name":"@s","objective":"note_id"},"color":"aqua"},{"text":" Pos=","color":"gold"},{"nbt":"Pos","entity":"@s","color":"aqua"}]
# 选中 ≥1 个 → 弹「已选定音符列表」；0 个 → 提示无命中并回主菜单
# （去除了「只选中 1 个 → 直接打开编辑面板」的特性）
execute if score #sel_count editor matches 0 run tellraw @s [{"text":"[编辑器] 选区内没有活跃音符","color":"red"}]
execute if score #sel_count editor matches 0 run function rhythm_axe:editor/menu/main
execute unless score #sel_count editor matches 0 run function rhythm_axe:editor/menu/note/selected/sel_note_list_open
