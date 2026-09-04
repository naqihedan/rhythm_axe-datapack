# 已选定音符列表遍历驱动器（普通函数）——按 selection 逐项驱动，用 find_by_id 找对应音符
# ★ 2026-09-05 重构：不再"顺序匹配 notes vs selection"（那样要求 selection 在 notes 中严格递增；
#   用户乱序点击/删除后顺序不一致 → 只显示前几个匹配的）。改按 selection 驱动（每个选中 id 独立 find），
#   任何顺序/已删都能正确显示所有还能找到的选中音符。
# 前置：prop.cursor（=history_cursor）、#sel_i（selection 游标）、#sel_total（选中数）、#sel_page_start
# 宏叶子 sel_note_list_row 处理单个选中（读 selection[$(sel_i)] → find_by_id → 渲染/跳过）
# 全部选中已处理 → 结束
execute if score #sel_i editor >= #sel_total editor run return 0
# 交给宏叶子处理当前选中项
scoreboard players set #show_row editor 0
function rhythm_axe:editor/menu/note/selected/sel_note_list_row with storage rhythm_axe:prop
# 推进 selection 游标（无论命中与否都推进，因为宏叶子内部已判断并渲染/跳过）
scoreboard players add #sel_i editor 1
execute store result storage rhythm_axe:prop sel_i int 1 run scoreboard players get #sel_i editor
# 继续处理下一个选中
execute if score #sel_i editor < #sel_total editor run function rhythm_axe:editor/menu/note/selected/sel_note_list_drive
