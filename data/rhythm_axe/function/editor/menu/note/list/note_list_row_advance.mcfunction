# 音符列表遍历驱动器（普通函数，非宏）——处理当前索引，再递增并继续
# ★ 2026-08-25 重构：26.x 下宏函数若位于递归栈中段（宏内调用 advance），展开结束后会从函数中间点
#   重跑剩余代码（幽灵行 bug）。故改为：所有递归都在普通函数里做，宏 row2 只做"叶子"单音符处理。
# 调用前需设置：storage prop.cursor、prop.index；score #note_alive editor（note_total 由 row2 顶部计算）
# 先处理当前音符（宏叶子函数，内部不递归、不调用 advance）
scoreboard players set #show_row editor 0
function rhythm_axe:editor/menu/note/list/note_list_row2 with storage rhythm_axe:prop
# 递增索引
execute store result score #index editor run data get storage rhythm_axe:prop index
scoreboard players add #index editor 1
execute store result storage rhythm_axe:prop index int 1 run scoreboard players get #index editor
# 未越界则继续（普通函数递归可靠）
execute if score #index editor < #note_total editor run function rhythm_axe:editor/menu/note/list/note_list_row_advance
