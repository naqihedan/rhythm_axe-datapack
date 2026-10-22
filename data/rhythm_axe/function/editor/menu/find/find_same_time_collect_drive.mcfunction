# 第一趟驱动器（普通函数，防宏递归幽灵）：遍历 selection[]，逐个 find_by_id 取 time 写进 prop.same_times
# ★ 三跳结构（绕开「同一宏实例内先写 prop 再 $(...) 读 = 拿旧值」的坑）：
#   ① collect_leaf（宏）：跑 find_by_id + 把 found_index 拷到固定路径 prop.st_found；
#   ② 驱动器（本文件）：读 st_found 分数 → 调 readtime_found（宏，$(st_found) 是新值）读 time 进 prop.st_time → 读 st_time 分数；
#   ③ collect_append（宏）：$(st_time) 是②刚读好的新值 → 写 same_times.<time>=1b。
# 前置：#st_i（selection 下标）、#st_total（selection 长度）、prop.cursor
execute if score #st_i editor >= #st_total editor run return 0
execute store result storage rhythm_axe:prop idx int 1 run scoreboard players get #st_i editor
function rhythm_axe:editor/menu/find/find_same_time_collect_leaf with storage rhythm_axe:prop
# 读第一跳结果 → 分数（未命中时 st_found 缺失 → -1）
scoreboard players set #st_found editor -1
execute if data storage rhythm_axe:prop st_found run execute store result score #st_found editor run data get storage rhythm_axe:prop st_found
# ② 读 time（st_found ≥ 0 时）：readtime_found 用 $(st_found)（新值）定位 notes 下标
data modify storage rhythm_axe:prop st_time set value -1
execute if score #st_found editor matches 0.. run execute store result storage rhythm_axe:prop st_found int 1 run scoreboard players get #st_found editor
execute if score #st_found editor matches 0.. run function rhythm_axe:editor/menu/find/find_same_time_readtime_found with storage rhythm_axe:prop
# 读 time 结果 → 分数 → 传给写入叶子
scoreboard players set #st_time editor -1
execute if data storage rhythm_axe:prop st_time run execute store result score #st_time editor run data get storage rhythm_axe:prop st_time
execute store result storage rhythm_axe:prop st_time int 1 run scoreboard players get #st_time editor
function rhythm_axe:editor/menu/find/find_same_time_collect_append with storage rhythm_axe:prop
data remove storage rhythm_axe:prop st_found
data remove storage rhythm_axe:prop st_time
scoreboard players add #st_i editor 1
function rhythm_axe:editor/menu/find/find_same_time_collect_drive
