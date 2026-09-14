# 遍历 notes：移除所有音符的 selected 标记
# ★ 2026-09-14：终止条件由「#sel_i >= #notes_len」改为「元素存在性探测（sel_rebuild_probe）」
#   —— 取 #notes_len 要 `data get storage ... notes`，会把整个列表序列化（976 音符 ≈260KB）。
execute if score #sel_has editor matches 0 run return 0
execute store result storage rhythm_axe:prop i int 1 run scoreboard players get #sel_i editor
function rhythm_axe:editor/menu/note/selected/sel_rebuild_probe with storage rhythm_axe:prop
execute if score #sel_has editor matches 0 run return 0
function rhythm_axe:editor/menu/note/selected/sel_clear_leaf with storage rhythm_axe:prop
scoreboard players add #sel_i editor 1
function rhythm_axe:editor/menu/note/selected/sel_clear_drive
