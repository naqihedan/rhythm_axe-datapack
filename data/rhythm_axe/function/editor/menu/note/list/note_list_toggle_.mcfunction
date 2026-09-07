#arg:cursor,index
# 复选框 toggle 叶子（宏）：读目标音符 id，判断是否已选中；已选=取消选中，未选=选中（复用 note_click_select）
# @s = 玩家
$execute store result score #nc_id editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].id
scoreboard players set #sel_on editor 0
execute as @e[type=interaction,tag=editor_note_selected] if score @s note_id = #nc_id editor run scoreboard players set #sel_on editor 1
# 未选 → 选中（复用 note_click_select：标记实体+高亮+加入 selection）
execute if score #sel_on editor matches 0 run function rhythm_axe:editor/tool/note_click_select
# 已选 → 取消选中（熄灭高亮 + 移除 selection）
execute if score #sel_on editor matches 1 run execute as @e[type=item_display,tag=editor_note] if score @s note_id = #nc_id editor run data modify entity @s Glowing set value 0b
execute if score #sel_on editor matches 1 run execute as @e[type=item_display,tag=editor_note] if score @s note_id = #nc_id editor run data remove entity @s glow_color_override
execute if score #sel_on editor matches 1 run execute as @e[type=interaction,tag=editor_note] if score @s note_id = #nc_id editor run tag @s remove editor_note_selected
execute if score #sel_on editor matches 1 run execute store result storage rhythm_axe:prop nid int 1 run scoreboard players get #nc_id editor
execute if score #sel_on editor matches 1 run function rhythm_axe:editor/menu/note/selected/sel_deselect_by_id
execute if score #sel_on editor matches 1 run data remove storage rhythm_axe:prop nid
# 同步选中数量
execute store result score #sel_count editor run data get storage rhythm_axe:maps.editor selection
