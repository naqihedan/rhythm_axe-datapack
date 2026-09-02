# 取消选中已被右击的音符（@s = 玩家；#nc_id = 音符 id）
# 熄灭该音符展示实体高亮
execute as @e[type=item_display,tag=editor_note] if score @s note_id = #nc_id editor run data modify entity @s Glowing set value 0b
execute as @e[type=item_display,tag=editor_note] if score @s note_id = #nc_id editor run data remove entity @s glow_color_override
# 从 selection 移除该 id（重建列表，跳过 #rm_id）
execute if score debug_output options matches 1.. run tellraw @s [{"text":"[调试.lv1][rm]","color":"gray"},{"text":" 待移除 #nc_id=","color":"gold"},{"score":{"name":"#nc_id","objective":"editor"},"color":"aqua"},{"text":" 移除前 selection=","color":"gold"},{"nbt":"selection","storage":"rhythm_axe:maps.editor","color":"aqua"}]
data modify storage rhythm_axe:prop rm_out set value []
data modify storage rhythm_axe:prop rm_idx set value 0
execute store result score #rm_id editor run scoreboard players get #nc_id editor
function rhythm_axe:editor/menu/note/selected/sel_remove_drive
execute if score debug_output options matches 1.. run tellraw @s [{"text":"[调试.lv1][rm]","color":"gray"},{"text":" 移除后 selection=","color":"gold"},{"nbt":"selection","storage":"rhythm_axe:maps.editor","color":"aqua"}]
data remove storage rhythm_axe:prop rm_out
data remove storage rhythm_axe:prop rm_idx
# 同步 #sel_count（下限 0 保护）
scoreboard players remove #sel_count editor 1
execute if score #sel_count editor matches ..-1 run scoreboard players set #sel_count editor 0
# 取消选中后弹出「已选定音符列表」面板（显示剩余选中）
data modify storage rhythm_axe:maps.editor feedback set value "已取消选中音符"
function rhythm_axe:editor/menu/note/selected/sel_note_list_open
