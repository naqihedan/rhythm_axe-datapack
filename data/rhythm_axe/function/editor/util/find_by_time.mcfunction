# 按 time 查找第一个 time==prop.target_time 的元素（普通函数驱动，规避 26.x 宏递归"幽灵重跑"）
# 前置：prop.cursor、prop.list_name（"timing_points" 或 "events"）、prop.index（起始 0）、prop.target_time；命中写 prop.found_index
# 退出标志 #find_done 由叶子设置：1=命中 2=元素缺失=遍历结束 0=未命中继续
scoreboard players set #find_done editor 0
function rhythm_axe:editor/util/find_by_time_leaf with storage rhythm_axe:prop
execute if score #find_done editor matches 1 run return 0
execute if score #find_done editor matches 2 run return 0
# 递增索引继续（普通函数递归可靠）
execute store result score #index editor run data get storage rhythm_axe:prop index
scoreboard players add #index editor 1
execute store result storage rhythm_axe:prop index int 1 run scoreboard players get #index editor
function rhythm_axe:editor/util/find_by_time
