# 渲染当前页（两次遍历：先未选中，再选中置底）；前置：#note_page、#page_start、#note_lo、#note_hi
# 由普通函数驱动器 note_list_row_advance 驱动遍历（宏叶子 row2 不递归）
# ★ 2026-10-06 性能：遍历区间 = [#note_lo, #note_hi)（可能存活的窗口），不再从 0 全表遍历
#   #alive_prefix = 数组存活序计数器，每趟重置（只对存活音符 +1，与选中/分页无关）
scoreboard players set #note_alive editor 0
scoreboard players set #list_pass editor 0
execute store result storage rhythm_axe:prop index int 1 run scoreboard players get #note_lo editor
scoreboard players set #alive_prefix editor 0
function rhythm_axe:editor/menu/note/list/note_list_row_advance
scoreboard players set #list_pass editor 1
execute store result storage rhythm_axe:prop index int 1 run scoreboard players get #note_lo editor
scoreboard players set #alive_prefix editor 0
function rhythm_axe:editor/menu/note/list/note_list_row_advance
