#arg:sel_idx
# 已选定列表复选框点击：取消选中该音符并重开面板 18
# @s = 玩家；sel_idx = 该音符在 selection 里的下标
$execute store result score #t_id editor run data get storage rhythm_axe:maps.editor selection[$(sel_idx)]
# 熄灭高亮 + 移除选中 tag
execute as @e[type=item_display,tag=editor_note] if score @s note_id = #t_id editor run data modify entity @s Glowing set value 0b
execute as @e[type=item_display,tag=editor_note] if score @s note_id = #t_id editor run data remove entity @s glow_color_override
execute as @e[type=interaction,tag=editor_note] if score @s note_id = #t_id editor run tag @s remove editor_note_selected
# 从 selection 移除
data modify storage rhythm_axe:prop rm_out set value []
data modify storage rhythm_axe:prop rm_idx set value 0
scoreboard players operation #rm_id editor = #t_id editor
function rhythm_axe:editor/menu/note/selected/sel_remove_drive
data remove storage rhythm_axe:prop rm_out
data remove storage rhythm_axe:prop rm_idx
# 同步选中数量 + 重开已选定列表
execute store result score #sel_count editor run data get storage rhythm_axe:maps.editor selection
function rhythm_axe:editor/menu/note/selected/sel_note_list_open
