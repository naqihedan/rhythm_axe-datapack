# 探针驱动器（普通函数，递归）：遍历待选列表 #lb_i = 0.. #lb_n-1，找当前最高分
# 前置：#lb_n（len）、#lb_best = -1、#lb_best_i = -1、prop.mapid
execute store result storage rhythm_axe:prop i int 1 run scoreboard players get #lb_i menu
function rhythm_axe:map_list/lb/probe_a with storage rhythm_axe:prop
scoreboard players add #lb_i menu 1
execute if score #lb_i menu < #lb_n menu run function rhythm_axe:map_list/lb/probe_drive
