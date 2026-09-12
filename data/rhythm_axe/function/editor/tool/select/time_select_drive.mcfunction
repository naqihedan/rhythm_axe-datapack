# 时间范围判定驱动器（普通函数，逐下标递归推进；单个音符交给宏叶子判定）
# 与 sel_rebuild_drive 同款：普通驱动器 + 宏叶子（防宏递归重跑）
execute if score #ts_i editor >= #ts_len editor run return 0
execute store result storage rhythm_axe:prop i int 1 run scoreboard players get #ts_i editor
function rhythm_axe:editor/tool/select/time_select_judge with storage rhythm_axe:prop
scoreboard players add #ts_i editor 1
function rhythm_axe:editor/tool/select/time_select_drive
