# 查找音符·单步推进（普通函数递归，本刻内连跑；额度 #fn_chunk 由 find_note_scan_drive 置 0 起）
#   每步：额度 +1 → 越上界停 → 读下标进 prop.i → 宏叶子判定 → #fn_i +1 → 递归下一步。
#   额度满 64 由**本函数开头**拦截（不再递归），控制权回 find_note_scan_drive 决定 schedule 或收尾。
execute if score #fn_chunk editor matches 64 run return 0
execute if score #fn_i editor >= #fn_hi editor run return 0
scoreboard players add #fn_chunk editor 1
execute store result storage rhythm_axe:prop i int 1 run scoreboard players get #fn_i editor
function rhythm_axe:editor/menu/find/find_note_scan_judge with storage rhythm_axe:prop
scoreboard players add #fn_i editor 1
function rhythm_axe:editor/menu/find/find_note_scan_step
