#arg:idx
# 击打事件列表递归推进：算下一行按钮值（10000+(idx+1)*10+off）写入 prop 并调 row
$scoreboard players set #he_next editor $(idx)
scoreboard players add #he_next editor 1
execute store result storage rhythm_axe:prop idx int 1 run scoreboard players get #he_next editor
scoreboard players set #he_base editor 10000
scoreboard players operation #he_step editor = #he_next editor
scoreboard players operation #he_step editor *= 10 const
scoreboard players operation #he_base editor += #he_step editor
execute store result storage rhythm_axe:prop he_edit int 1 run scoreboard players get #he_base editor
scoreboard players operation #he_tmp editor = #he_base editor
scoreboard players add #he_tmp editor 1
execute store result storage rhythm_axe:prop he_copy int 1 run scoreboard players get #he_tmp editor
scoreboard players operation #he_tmp editor = #he_base editor
scoreboard players add #he_tmp editor 2
execute store result storage rhythm_axe:prop he_paste int 1 run scoreboard players get #he_tmp editor
scoreboard players operation #he_tmp editor = #he_base editor
scoreboard players add #he_tmp editor 3
execute store result storage rhythm_axe:prop he_del int 1 run scoreboard players get #he_tmp editor
function rhythm_axe:editor/menu/note/hit_events/note_hit_events_row with storage rhythm_axe:prop