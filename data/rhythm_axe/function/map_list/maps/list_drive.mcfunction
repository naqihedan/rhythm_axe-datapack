# 总表逐行渲染驱动器（普通函数自递归 + 宏叶子单步；避开 26.x 宏递归"幽灵重跑"）
# 前置：#ml_i = 本页第一行的真实下标、#ml_row = 0。退出：满 10 行 或 索引越界
#   注：`matches 100000` 是防呆上限（驱动器被绕过入口直调时不会失控）
execute if score #ml_row menu matches 10.. run return 0
execute if score #ml_i menu matches 100000 run return 0
execute store result storage rhythm_axe:prop i int 1 run scoreboard players get #ml_i menu
function rhythm_axe:maps/index/index_get with storage rhythm_axe:prop
execute unless data storage rhythm_axe:prop mapid run return 0
execute store result storage rhythm_axe:prop row int 1 run scoreboard players get #ml_row menu
function rhythm_axe:map_list/maps/list_row with storage rhythm_axe:prop
data remove storage rhythm_axe:prop mapid
scoreboard players add #ml_row menu 1
scoreboard players add #ml_i menu 1
function rhythm_axe:map_list/maps/list_drive
