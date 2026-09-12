# 正向扫描驱动器（普通函数，逐下标递归；单个音符交给宏叶子判定）
# 从 #ts_i（= 二分得到的「第一个 time ≥ min」下标）向后扫，遇到 time > max 时宏叶子置 #ts_stop → 立即停
# （notes 按 time 升序 → 后面的 time 只会更大，不可能命中）
execute if score #ts_i editor >= #ts_len editor run return 0
execute store result storage rhythm_axe:prop i int 1 run scoreboard players get #ts_i editor
function rhythm_axe:editor/tool/select/time_select_judge with storage rhythm_axe:prop
execute if score #ts_stop editor matches 1 run return 0
scoreboard players add #ts_i editor 1
function rhythm_axe:editor/tool/select/time_select_drive
