# 排行榜一轮：选出当前最高分 → 输出一行 → 从待选列表删除该人 → 递归（输出到第 10 名或列表空为止）
# 前置：#lb_n（剩余人数）、#lb_rank（当前名次）、prop.mapid
execute if score #lb_rank menu matches 11.. run return 0
scoreboard players set #lb_best menu -1
scoreboard players set #lb_best_i menu -1
scoreboard players set #lb_i menu 0
execute if score #lb_n menu matches 1.. run function rhythm_axe:map_list/lb/probe_drive
# 没人可选（列表空了 / 全被删完）→ 结束
execute unless score #lb_best_i menu matches 0.. run scoreboard players set #lb_n menu 0
execute unless score #lb_best_i menu matches 0.. run return 0
execute store result storage rhythm_axe:prop bi int 1 run scoreboard players get #lb_best_i menu
execute store result storage rhythm_axe:prop rank int 1 run scoreboard players get #lb_rank menu
# [x] 删除按钮值 = 11800 + 名次（11801..11810）——按钮值「记分板算出来再宏注入」的写法，
#   跟动态行列码那批一样，直接 grep 数字是查不到的
scoreboard players operation #lb_val menu = #lb_rank menu
scoreboard players add #lb_val menu 11800
execute store result storage rhythm_axe:prop del_val int 1 run scoreboard players get #lb_val menu
function rhythm_axe:map_list/lb/out_a with storage rhythm_axe:prop
function rhythm_axe:map_list/lb/out_b with storage rhythm_axe:prop
function rhythm_axe:map_list/lb/decorate
function rhythm_axe:map_list/lb/out_c with storage rhythm_axe:prop
scoreboard players add #lb_rank menu 1
scoreboard players remove #lb_n menu 1
execute if score #lb_n menu matches 1.. run function rhythm_axe:map_list/lb/pass
