# 遍历 maps.(prop.mapid).notes 移除 selected（普通驱动器 + 宏叶子，防宏递归重跑）
execute if score #i editor >= #notes_len editor run return 0
execute store result storage rhythm_axe:prop i int 1 run scoreboard players get #i editor
function rhythm_axe:editor/file/save_strip_leaf with storage rhythm_axe:prop
scoreboard players add #i editor 1
function rhythm_axe:editor/file/save_strip_drive
