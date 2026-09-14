# 清空所有选中：移除全部音符 selected + 清空 selection
# ★ 2026-09-14：不再调 sel_rebuild_len 取长度（`data get ... notes` 会把整表序列化 ≈260KB）
data modify storage rhythm_axe:maps.editor selection set value []
data modify storage rhythm_axe:prop cursor set from storage rhythm_axe:maps.editor history_cursor
scoreboard players set #sel_has editor 1
scoreboard players set #sel_i editor 0
function rhythm_axe:editor/menu/note/selected/sel_clear_drive
data remove storage rhythm_axe:prop cursor
data remove storage rhythm_axe:prop i
