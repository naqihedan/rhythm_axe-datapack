# 选中被点击音符（@s = 玩家；#nc_id = 音符 id；效果同选择工具选择）
# 标记交互/展示实体 + 高亮 + 加入 selection[]
execute as @e[type=interaction,tag=editor_note] if score @s note_id = #nc_id editor run tag @s add editor_note_selected
execute as @e[type=item_display,tag=editor_note] if score @s note_id = #nc_id editor run data modify entity @s Glowing set value 1b
execute as @e[type=item_display,tag=editor_note] if score @s note_id = #nc_id editor run data modify entity @s glow_color_override set value 16776960
# 去重：先清掉 selection 中可能残留的本音符 id，再追加一次（防止反复左/右键重复添加）
data modify storage rhythm_axe:prop rm_out set value []
data modify storage rhythm_axe:prop rm_idx set value 0
execute store result score #rm_id editor run scoreboard players get #nc_id editor
function rhythm_axe:editor/menu/note/selected/sel_remove_drive
data remove storage rhythm_axe:prop rm_out
data remove storage rhythm_axe:prop rm_idx
execute store result storage rhythm_axe:prop nid int 1 run scoreboard players get #nc_id editor
data modify storage rhythm_axe:maps.editor selection append from storage rhythm_axe:prop nid
data remove storage rhythm_axe:prop nid
# 同步维护选中数量（与选择工具 select_inter 一致）
scoreboard players add #sel_count editor 1
tellraw @s [{"text":"[编辑器] 已选中音符 ","color":"yellow"},{"score":{"name":"#nc_id","objective":"editor"},"color":"aqua"},{"text":"（再次点击打开编辑面板）","color":"gray"}]
