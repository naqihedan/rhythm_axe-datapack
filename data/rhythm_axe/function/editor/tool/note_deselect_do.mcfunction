# 取消选中已被右击的音符（@s = 玩家；#nc_id = 音符 id）
# 熄灭该音符展示实体高亮
execute as @e[type=item_display,tag=editor_note] if score @s note_id = #nc_id editor run data modify entity @s Glowing set value 0b
execute as @e[type=item_display,tag=editor_note] if score @s note_id = #nc_id editor run data remove entity @s glow_color_override
# 移除该音符的 selected 标记，再重建 selection
execute store result storage rhythm_axe:prop nid int 1 run scoreboard players get #nc_id editor
function rhythm_axe:editor/menu/note/selected/sel_deselect_by_id
data remove storage rhythm_axe:prop nid
# 同步 #sel_count（从 selection 长度重算）
execute store result score #sel_count editor run data get storage rhythm_axe:maps.editor selection
# 取消选中后弹出「已选定音符列表」面板（显示剩余选中）
data modify storage rhythm_axe:maps.editor feedback set value "已取消选中音符"
function rhythm_axe:editor/menu/note/selected/sel_note_list_open
