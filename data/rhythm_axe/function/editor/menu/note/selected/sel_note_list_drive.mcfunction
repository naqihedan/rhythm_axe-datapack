# 已选定音符列表遍历驱动器（普通函数）：只遍历“当前页”的选中项（页起点..页起点+39），每项交宏叶子渲染一行
# ★ 2026-09-11 优化：原实现遍历全部 selection（选中 34 个即 34 次 find_by_id 全扫 notes → 超 maxCommandChainLength）。现：
#   ① 到页尾（#sel_i >= #sel_end）或选中遍历完（#sel_i >= #sel_total）即停，页外项完全不做 find；
#   ② 行内 find_by_id 用顺序游标（selection 已由 sel_rebuild 按 notes 顺序重建）→ 本页合计 O(n)。
# 前置：prop.cursor、#sel_i（选中序，0 起）、#sel_cursor、#sel_total、#sel_end
execute if score #sel_i editor >= #sel_total editor run return 0
execute if score #sel_i editor >= #sel_end editor run return 0
scoreboard players set #show_row editor 0
function rhythm_axe:editor/menu/note/selected/sel_note_list_row with storage rhythm_axe:prop
scoreboard players add #sel_i editor 1
execute store result storage rhythm_axe:prop sel_i int 1 run scoreboard players get #sel_i editor
execute if score #sel_i editor < #sel_total editor if score #sel_i editor < #sel_end editor run function rhythm_axe:editor/menu/note/selected/sel_note_list_drive
