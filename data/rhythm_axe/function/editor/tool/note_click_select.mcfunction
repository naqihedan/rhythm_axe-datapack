# 选中被点击音符（@s = 玩家；#nc_id = 音符 id；效果同选择工具选择）
# 标记交互/展示实体 + 高亮 + 加入 selection[]
execute as @e[type=interaction,tag=editor_note] if score @s note_id = #nc_id editor run tag @s add editor_note_selected
execute as @e[type=item_display,tag=editor_note] if score @s note_id = #nc_id editor run data modify entity @s Glowing set value 1b
execute as @e[type=item_display,tag=editor_note] if score @s note_id = #nc_id editor run data modify entity @s glow_color_override set value 16776960
# 给该音符元素设 selected 标记并重建 selection（selected 存 storage 不随 refresh 丢；selection 由 notes 遍历生成，天然有序）
execute store result storage rhythm_axe:prop nid int 1 run scoreboard players get #nc_id editor
function rhythm_axe:editor/menu/note/selected/sel_select_by_id
data remove storage rhythm_axe:prop nid
# 同步维护选中数量（从 selection 长度重算，避免重复点击漂移）
execute store result score #sel_count editor run data get storage rhythm_axe:maps.editor selection
tellraw @s [{"text":"[编辑器] 已选中音符 ","color":"yellow"},{"score":{"name":"#nc_id","objective":"editor"},"color":"aqua"},{"text":"（再次点击打开编辑面板）","color":"gray"}]
