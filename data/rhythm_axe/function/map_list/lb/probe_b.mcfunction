#arg:key,mapid
# 探针第二层：读该玩家在这张谱面上的分数，与当前最好成绩比较（更高则记下分数与下标）
$execute store result score #lb_cur menu run data get storage rhythm_axe:scores $(key).$(mapid).score
execute if score #lb_cur menu > #lb_best menu run scoreboard players operation #lb_best_i menu = #lb_i menu
execute if score #lb_cur menu > #lb_best menu run scoreboard players operation #lb_best menu = #lb_cur menu
