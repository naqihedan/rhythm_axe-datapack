# 遍历 maps.(prop.mapid).notes 移除 selected（普通驱动器 + 宏叶子，防宏递归重跑）
# ★ 2026-09-14：终止条件由「#i >= #notes_len」改为「元素存在性探测（save_strip_probe）」
#   —— 取 #notes_len 要 `data get storage ... notes`，会把整个列表序列化（千音符 ≈260KB）。
execute if score #strip_has editor matches 0 run return 0
execute store result storage rhythm_axe:prop i int 1 run scoreboard players get #i editor
function rhythm_axe:editor/file/save_strip_probe with storage rhythm_axe:prop
execute if score #strip_has editor matches 0 run return 0
function rhythm_axe:editor/file/save_strip_leaf with storage rhythm_axe:prop
scoreboard players add #i editor 1
function rhythm_axe:editor/file/save_strip_drive
