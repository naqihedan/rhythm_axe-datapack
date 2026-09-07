# 清空所有选中：移除全部音符 selected + 清空 selection
data modify storage rhythm_axe:maps.editor selection set value []
data modify storage rhythm_axe:prop cursor set from storage rhythm_axe:maps.editor history_cursor
function rhythm_axe:editor/menu/note/selected/sel_rebuild_len with storage rhythm_axe:prop
scoreboard players set #sel_i editor 0
function rhythm_axe:editor/menu/note/selected/sel_clear_drive
data remove storage rhythm_axe:prop cursor
data remove storage rhythm_axe:prop i
