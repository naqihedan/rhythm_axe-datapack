# 存活查找遍历驱动器（普通函数，非宏）——处理当前索引，命中即停，否则递增继续
# ★ 2026-08-25 重构（同 note_list_row）：26.x 宏函数在递归栈中段会触发幽灵重跑，故所有递归走普通函数，
#   宏 note_find_alive 只做"叶子"单音符处理。
# 调用前需设置：storage prop.cursor、prop.index、prop.target、prop.count；score #note_total 由叶子顶部计算
scoreboard players set #note_found editor 0
function rhythm_axe:editor/menu/note/list/note_find_alive with storage rhythm_axe:prop
# 命中目标即停（普通函数 return 可靠）
execute if score #note_found editor matches 1 run return 0
# 递增索引
execute store result score #index editor run data get storage rhythm_axe:prop index
scoreboard players add #index editor 1
execute store result storage rhythm_axe:prop index int 1 run scoreboard players get #index editor
# 未越界则继续
execute if score #index editor < #note_total editor run function rhythm_axe:editor/menu/note/list/note_find_alive_advance
