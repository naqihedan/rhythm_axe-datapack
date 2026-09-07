# 遍历 notes（时间序）逐个音符：命中（存活且未选中）→ 追加 {id, idx} 到 selection
# 普通驱动器 + 宏叶子（防宏递归重跑）
execute if score #sel_i editor >= #notes_len editor run return 0
execute store result storage rhythm_axe:prop i int 1 run scoreboard players get #sel_i editor
function rhythm_axe:editor/menu/note/list/sel_all_readid with storage rhythm_axe:prop
function rhythm_axe:editor/menu/note/list/sel_all_judge with storage rhythm_axe:prop
scoreboard players add #sel_i editor 1
function rhythm_axe:editor/menu/note/list/sel_all_drive
