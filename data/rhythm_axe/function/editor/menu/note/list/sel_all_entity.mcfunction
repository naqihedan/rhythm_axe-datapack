# @s = 单个存活音符的展示实体
# 若该音符尚未选中（对应交互实体无 editor_note_selected），则追加进 selection + 标记 + 高亮；已选中则跳过
execute store result score #t_id editor run scoreboard players get @s note_id
scoreboard players set #sel_on editor 0
execute as @e[type=interaction,tag=editor_note_selected] if score @s note_id = #t_id editor run scoreboard players set #sel_on editor 1
execute if score #sel_on editor matches 0 run execute store result storage rhythm_axe:prop idx int 1 run scoreboard players get @s editor_n_idx
execute if score #sel_on editor matches 0 run function rhythm_axe:editor/menu/note/selected/sel_select_one with storage rhythm_axe:prop
execute if score #sel_on editor matches 0 run data remove storage rhythm_axe:prop idx
execute if score #sel_on editor matches 0 run execute as @e[type=interaction,tag=editor_note] if score @s note_id = #t_id editor run tag @s add editor_note_selected
execute if score #sel_on editor matches 0 run data modify entity @s Glowing set value 1b
execute if score #sel_on editor matches 0 run data modify entity @s glow_color_override set value 16776960
