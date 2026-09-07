# 重建 selection：遍历 notes，收集带 selected:1b 的音符 id（按 notes 顺序，天然有序）
# ★ selected 标记存音符元素（storage，不随 refresh/重载丢失）；idx/time 变化不影响（选中跟音符走，顺序跟 notes 走）
data modify storage rhythm_axe:maps.editor selection set value []
data modify storage rhythm_axe:prop cursor set from storage rhythm_axe:maps.editor history_cursor
function rhythm_axe:editor/menu/note/selected/sel_rebuild_len with storage rhythm_axe:prop
scoreboard players set #sel_i editor 0
function rhythm_axe:editor/menu/note/selected/sel_rebuild_drive
data remove storage rhythm_axe:prop cursor
data remove storage rhythm_axe:prop i
data remove storage rhythm_axe:prop nid
