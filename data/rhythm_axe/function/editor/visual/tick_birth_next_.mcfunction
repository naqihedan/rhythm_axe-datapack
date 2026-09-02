# 播放新出生：推进游标 #vis_next 并继续（宏参数 note_idx）
#arg: note_idx
scoreboard players add #vis_next editor 1
execute store result storage rhythm_axe:prop note_idx int 1 run scoreboard players get #vis_next editor
function rhythm_axe:editor/visual/tick_birth_note_ with storage rhythm_axe:prop
