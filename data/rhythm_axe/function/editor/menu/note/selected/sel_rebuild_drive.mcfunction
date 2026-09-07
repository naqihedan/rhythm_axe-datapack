# 遍历 notes：带 selected:1b 的音符 id 追加到 selection（按 notes 顺序）
# 普通驱动器 + 宏叶子（防宏递归重跑）；judge 自读 id + 追加，无需单独 readid
execute if score #sel_i editor >= #notes_len editor run return 0
execute store result storage rhythm_axe:prop i int 1 run scoreboard players get #sel_i editor
function rhythm_axe:editor/menu/note/selected/sel_rebuild_judge with storage rhythm_axe:prop
scoreboard players add #sel_i editor 1
function rhythm_axe:editor/menu/note/selected/sel_rebuild_drive
