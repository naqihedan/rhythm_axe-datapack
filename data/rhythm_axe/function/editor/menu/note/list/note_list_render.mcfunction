# 渲染当前页（两次遍历：先未选中，再选中置底）；前置：#note_page、#page_start
# 由普通函数驱动器 note_list_row_advance 驱动遍历（宏叶子 row2 不递归）
scoreboard players set #note_alive editor 0
scoreboard players set #list_pass editor 0
data modify storage rhythm_axe:prop index set value 0
function rhythm_axe:editor/menu/note/list/note_list_row_advance
scoreboard players set #list_pass editor 1
data modify storage rhythm_axe:prop index set value 0
function rhythm_axe:editor/menu/note/list/note_list_row_advance
