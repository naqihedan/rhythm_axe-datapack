# 全部选中：把当前存活且**未选中**的音符标记 selected，再重建 selection（selection 由 notes 遍历生成，天然有序）
# ★ 2026-09-07 selected 存音符元素（storage，不随 refresh 丢）；O(n) 全选上百也不爆 200000
data modify storage rhythm_axe:prop cursor set from storage rhythm_axe:maps.editor history_cursor
execute as @e[type=item_display,tag=editor_note] run function rhythm_axe:editor/menu/note/list/sel_all_entity
function rhythm_axe:editor/menu/note/selected/sel_rebuild
data remove storage rhythm_axe:prop cursor
execute store result score #sel_count editor run data get storage rhythm_axe:maps.editor selection
function rhythm_axe:editor/menu/note/list/note_list_open
