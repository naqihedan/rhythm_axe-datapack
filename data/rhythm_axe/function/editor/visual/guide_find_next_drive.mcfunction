# 向后查找普通音符 B：驱动器（普通函数，可递归安全）——宏叶子只负责探测单个下标
# 终止：找到（#gnx_end=1）或越界（叶子发现该下标无音符 → #gnx_end=1）
# 防呆：向前探测下标超上限直接停（正常由叶子在越界时置 #gnx_end=1 终止）
execute if score #gnx_walk editor matches 1000000.. run return 0
execute if score #gnx_end editor matches 1 run return 0
execute store result storage rhythm_axe:prop i int 1 run scoreboard players get #gnx_walk editor
function rhythm_axe:editor/visual/guide_find_next_leaf with storage rhythm_axe:prop
execute if score #gnx_end editor matches 1 run return 0
scoreboard players add #gnx_walk editor 1
function rhythm_axe:editor/visual/guide_find_next_drive
