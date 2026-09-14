# 指数查找上界（普通函数驱动，可递归）：把 #ins_hi 推到「首个不存在 或 time > 新 time」的下标
# 不变式：#ins_lo 存在且 time <= 新 time；#ins_hi > #ins_lo
# 上界保护：超过 2^20（1048576）直接转二分，避免失控
execute if score #ins_hi editor matches 1048577.. run function rhythm_axe:editor/util/insert_find_bin with storage rhythm_axe:prop
execute if score #ins_hi editor matches 1048577.. run return 0
execute store result storage rhythm_axe:prop i int 1 run scoreboard players get #ins_hi editor
function rhythm_axe:editor/util/insert_find_probe with storage rhythm_axe:prop
# 「存在且 time <= 新 time」→ lo = hi，hi *= 2，继续扩展
scoreboard players set #ins_go editor 0
execute if score #ins_ex editor matches 1 if score #ins_t editor <= #ins_new editor run scoreboard players set #ins_go editor 1
execute if score #ins_go editor matches 1 run scoreboard players operation #ins_lo editor = #ins_hi editor
execute if score #ins_go editor matches 1 run scoreboard players operation #ins_hi editor *= #ins_two editor
execute if score #ins_go editor matches 1 run function rhythm_axe:editor/util/insert_find_exp with storage rhythm_axe:prop
execute if score #ins_go editor matches 1 run return 0
# 否则（不存在 / 更大）→ 上界已找到，转二分
function rhythm_axe:editor/util/insert_find_bin with storage rhythm_axe:prop
