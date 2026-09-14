# 音符数组「顺序修复」：把 notes 重新整理成按 time 非递减（稳定：只在严格 > 时交换相邻两个）
# 前置：prop.cursor 可省（缺省取 history_cursor）；本函数**只改数组顺序**，不改任何音符字段
# 输出：#ord_swaps = 交换次数（0 = 本来就有序）
#
# ★ 背景（2026-09-14 排查结论）：批量修改的「判定时间」（batch_apply_one）是**原地改 time**，
#   只改选中子集、不重排数组 → 选中组一挪动就跨过未选中的邻居 → 局部逆序（回退量 = 增量）。
#   逆序会连累：insert_find（「遇到第一个 time 更大就插」→ 插入点错、逆序自我累积）、
#   time_select 的二分查找（范围选择边界错）、sel_rebuild / 活跃列表（按数组序 → 列表顺序倒挂）、
#   出生游标 #vis_next / tick_birth_*（顺序推进 → 逆序处可能提前停、漏生音符）。
#   判定本身按各自 time 与播放头比较 → 不受影响（所以一直没被察觉）。
#
# ★ 修复会改变数组下标顺序 → 调用方必须紧跟一次 refresh（重建视觉 / 选区 / guide_prev）。
# 实现：相邻交换 + 回退一格的冒泡（驱动器用普通函数、叶子用宏，规避 26.x 宏递归问题）
execute unless data storage rhythm_axe:prop cursor run execute store result storage rhythm_axe:prop cursor int 1 run data get storage rhythm_axe:maps.editor history_cursor
scoreboard players set #ord_swaps editor 0
scoreboard players set #ord_next editor 0
scoreboard players set #ord_done editor 0
data modify storage rhythm_axe:prop i set value 0
data modify storage rhythm_axe:prop i1 set value 1
function rhythm_axe:editor/util/order_repair_drive
data remove storage rhythm_axe:prop i
data remove storage rhythm_axe:prop i1
