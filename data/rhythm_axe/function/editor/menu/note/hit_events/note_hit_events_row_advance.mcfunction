#arg:idx
# 击打事件列表递归推进：算下一行按钮值（规范v2 = (1000+(idx+1))×100 + 列码）写入 prop 并调 row
$scoreboard players set #he_next editor $(idx)
scoreboard players add #he_next editor 1
execute store result storage rhythm_axe:prop idx int 1 run scoreboard players get #he_next editor
scoreboard players set #he_base editor 1000
scoreboard players operation #he_base editor += #he_next editor
scoreboard players operation #he_base editor *= 100 const
scoreboard players add #he_base editor 3
execute store result storage rhythm_axe:prop he_edit int 1 run scoreboard players get #he_base editor
scoreboard players remove #he_base editor 3
scoreboard players operation #he_tmp editor = #he_base editor
scoreboard players add #he_tmp editor 5
execute store result storage rhythm_axe:prop he_copy int 1 run scoreboard players get #he_tmp editor
scoreboard players operation #he_tmp editor = #he_base editor
scoreboard players add #he_tmp editor 6
execute store result storage rhythm_axe:prop he_paste int 1 run scoreboard players get #he_tmp editor
scoreboard players operation #he_tmp editor = #he_base editor
scoreboard players add #he_tmp editor 7
execute store result storage rhythm_axe:prop he_del int 1 run scoreboard players get #he_tmp editor
function rhythm_axe:editor/menu/note/hit_events/note_hit_events_row with storage rhythm_axe:prop