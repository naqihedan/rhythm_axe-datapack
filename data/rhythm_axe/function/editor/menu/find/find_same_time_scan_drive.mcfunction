# 第二趟驱动器（普通函数，防宏递归幽灵）：全表扫 notes，逐个交给宏叶子判定
# 终止：元素存在性探测（sel_rebuild_probe 同款，避免整表序列化取长度）
# ★ 叶子需要 time 作宏参数（稀疏数组下标探测）⇒ 驱动器先把 notes[i].time 读进 prop.st_time
#   再以 (cursor,i,st_time) 调叶子；time 缺失（坏元素）按 -1 传（叶子探测不命中，自然跳过）。
# 前置：#st_j（notes 下标）、prop.cursor；#st_hit 新增计数
execute if score #st_j editor matches 1000000.. run return 0
execute if score #st_has editor matches 0 run return 0
execute store result storage rhythm_axe:prop i int 1 run scoreboard players get #st_j editor
function rhythm_axe:editor/menu/note/selected/sel_rebuild_probe with storage rhythm_axe:prop
execute if score #st_has editor matches 0 run return 0
# 读 time 进 prop.st_time（缺 time 的坏元素 → -1）；★ 读值行放叶子 find_same_time_readtime（宏行）
data modify storage rhythm_axe:prop st_time set value -1
function rhythm_axe:editor/menu/find/find_same_time_readtime with storage rhythm_axe:prop
function rhythm_axe:editor/menu/find/find_same_time_scan_judge with storage rhythm_axe:prop
data remove storage rhythm_axe:prop st_time
scoreboard players add #st_j editor 1
function rhythm_axe:editor/menu/find/find_same_time_scan_drive
