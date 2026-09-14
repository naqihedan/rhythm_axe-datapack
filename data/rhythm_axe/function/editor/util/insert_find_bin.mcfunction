# 二分收敛（普通函数驱动，可递归）：不变式见 insert_find_exp
# 结束：#ins_hi - #ins_lo <= 1 → #ins_hi 即插入点（首个不存在或 time > 新 time 的下标）
scoreboard players operation #ins_d editor = #ins_hi editor
scoreboard players operation #ins_d editor -= #ins_lo editor
execute if score #ins_d editor matches ..1 run function rhythm_axe:editor/util/insert_find_done with storage rhythm_axe:prop
execute if score #ins_d editor matches ..1 run return 0
scoreboard players operation #ins_mid editor = #ins_lo editor
scoreboard players operation #ins_mid editor += #ins_hi editor
scoreboard players operation #ins_mid editor /= #ins_two editor
execute store result storage rhythm_axe:prop i int 1 run scoreboard players get #ins_mid editor
function rhythm_axe:editor/util/insert_find_probe with storage rhythm_axe:prop
scoreboard players set #ins_go editor 0
execute if score #ins_ex editor matches 1 if score #ins_t editor <= #ins_new editor run scoreboard players set #ins_go editor 1
execute if score #ins_go editor matches 1 run scoreboard players operation #ins_lo editor = #ins_mid editor
execute unless score #ins_go editor matches 1 run scoreboard players operation #ins_hi editor = #ins_mid editor
function rhythm_axe:editor/util/insert_find_bin with storage rhythm_axe:prop
