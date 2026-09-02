# 诊断宏子函数（#arg: cursor；由 diag 入口传 cursor）
#arg: cursor
$execute store result score #d_notes editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes
execute if score debug_output options matches 1.. run tellraw @a ["",{"text":"[调试.lv1][diag]","color":"gray"},{"text":" 音符数: ","color":"gold"},{"score":{"name":"#d_notes","objective":"editor"}}]
execute store result score #d_ph editor run scoreboard players get #playhead editor
execute if score debug_output options matches 1.. run tellraw @a ["",{"text":"[调试.lv1][diag]","color":"gray"},{"text":" playhead: ","color":"gold"},{"score":{"name":"#d_ph","objective":"editor"}}]
execute store result score #d_ns editor run scoreboard players get note_speed options
execute if score debug_output options matches 1.. run tellraw @a ["",{"text":"[调试.lv1][diag]","color":"gray"},{"text":" note_speed: ","color":"gold"},{"score":{"name":"#d_ns","objective":"editor"}}]
$execute store result score #d0_time editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[0].time
$execute store result score #d0_type editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[0].type
execute if score debug_output options matches 1.. run tellraw @a ["",{"text":"[调试.lv1][diag]","color":"gray"},{"text":" notes[0] time: ","color":"gold"},{"score":{"name":"#d0_time","objective":"editor"}},{"text":"  type: ","color":"gold"},{"score":{"name":"#d0_type","objective":"editor"}}]
execute if entity @e[tag=editor_note,type=item_display] run execute if score debug_output options matches 1.. run tellraw @a ["",{"text":"[调试.lv1][diag]","color":"gray"},{"text":" 展示实体 Pos: ","color":"green"},{"nbt":"Pos","entity":"@e[tag=editor_note,type=item_display,limit=1]","color":"aqua"}]
execute unless entity @e[tag=editor_note,type=item_display] run execute if score debug_output options matches 1.. run tellraw @a ["",{"text":"[调试.lv1][diag]","color":"gray"},{"text":" 无展示实体（未生成）","color":"red"}]
execute store result score #d_nxt editor run scoreboard players get #vis_next editor
execute store result score #d_idx editor run scoreboard players get #vis_idx editor
execute if score debug_output options matches 1.. run tellraw @a ["",{"text":"[调试.lv1][diag]","color":"gray"},{"text":" vis_next: ","color":"gold"},{"score":{"name":"#d_nxt","objective":"editor"}},{"text":"  vis_idx: ","color":"gold"},{"score":{"name":"#d_idx","objective":"editor"}}]
