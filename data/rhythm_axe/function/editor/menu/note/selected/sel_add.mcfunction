# 按住 idx（音符在 notes 的下标，即 time 升序）把 {id, idx} 插入 selection（若 selection 为空则 append）
# ★ 2026-09-07 选中时按时间插入：让 selection 始终按 idx 升序 → copy_cursor/paste_find/cut_remove 等"严格递增"假设天然成立
#   元素带 idx，插入只需比较 selection[i].idx（O(选中数) 数据操作），无需逐个 find，selection 再大也不爆 200000
# 前置：prop.nid（音符 id）、prop.sel_idx（该音符在 notes 的下标）；@s = 执行者（任意）
execute store result score #sel_key editor run data get storage rhythm_axe:prop sel_idx
execute store result score #sel_len editor run data get storage rhythm_axe:maps.editor selection
execute if score #sel_len editor matches 0 run function rhythm_axe:editor/menu/note/selected/sel_add_append with storage rhythm_axe:prop
execute if score #sel_len editor matches 0 run return 0
scoreboard players set #sel_i editor 0
function rhythm_axe:editor/menu/note/selected/sel_add_drive
