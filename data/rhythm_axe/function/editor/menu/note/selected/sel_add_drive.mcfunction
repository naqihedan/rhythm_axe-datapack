# 遍历 selection 找插入位置：selection[i].idx > 新 idx 处插入，否则继续；越界 append
# 普通驱动器（推进）+ 宏叶子（比较）；selection 元素为 {id, idx}
execute if score #sel_i editor >= #sel_len editor run function rhythm_axe:editor/menu/note/selected/sel_add_append with storage rhythm_axe:prop
execute if score #sel_i editor >= #sel_len editor run return 0
execute store result storage rhythm_axe:prop i int 1 run scoreboard players get #sel_i editor
function rhythm_axe:editor/menu/note/selected/sel_add_leaf with storage rhythm_axe:prop
# 若 selection[i].idx > 新 idx → 在此插入
execute if score #cur_idx editor > #sel_key editor run function rhythm_axe:editor/menu/note/selected/sel_add_insert with storage rhythm_axe:prop
execute if score #cur_idx editor > #sel_key editor run return 0
scoreboard players add #sel_i editor 1
function rhythm_axe:editor/menu/note/selected/sel_add_drive
