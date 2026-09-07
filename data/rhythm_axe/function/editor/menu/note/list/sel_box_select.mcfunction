# 框选：按时间序遍历 notes 一次生成有序 selection（元素 {id, idx}；O(n) 不爆 200000）
# ★ 2026-09-07 替换原"逐交互实体判定+逐个插入"（框选上百会 O(n²) 爆）
# 前置：prop.minx..maxz（选区）、selection 已清空（由 select_second 清）；cursor 在此设置
data modify storage rhythm_axe:prop cursor set from storage rhythm_axe:maps.editor history_cursor
function rhythm_axe:editor/menu/note/list/sel_all_len with storage rhythm_axe:prop
scoreboard players set #sel_i editor 0
function rhythm_axe:editor/menu/note/list/sel_box_drive
data remove storage rhythm_axe:prop cursor
data remove storage rhythm_axe:prop i
data remove storage rhythm_axe:prop nid
execute store result score #sel_count editor run data get storage rhythm_axe:maps.editor selection
