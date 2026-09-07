# 遍历 notes：移除所有音符的 selected 标记
execute if score #sel_i editor >= #notes_len editor run return 0
execute store result storage rhythm_axe:prop i int 1 run scoreboard players get #sel_i editor
function rhythm_axe:editor/menu/note/selected/sel_clear_leaf with storage rhythm_axe:prop
scoreboard players add #sel_i editor 1
function rhythm_axe:editor/menu/note/selected/sel_clear_drive
