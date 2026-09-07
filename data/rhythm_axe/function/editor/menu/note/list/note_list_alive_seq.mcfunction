# 预计算数组存活序：遍历 notes（数组序），给每个音符记"数组存活序"（0-based）存入 prop.alive_seq
# 非存活/无效音符存 -1；供 note_list_row2 用数组存活序做按钮值（修复"选中置底后按钮定位错位"）
# 前置：prop.cursor（work copy）
data modify storage rhythm_axe:prop alive_seq set value []
scoreboard players set #alive_c editor 0
scoreboard players set #alive_idx editor 0
data modify storage rhythm_axe:prop alive_idx set value 0
function rhythm_axe:editor/menu/note/list/note_list_alive_seq_drive
data remove storage rhythm_axe:prop alive_idx
