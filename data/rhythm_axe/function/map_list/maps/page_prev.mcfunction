# 总表上一页（11701）：页号 -1（下界 0），重绘
# 说明：越界由 list_open 的钳制兜底（页号会夹到 [0, 页数-1]），这里只做减一。
scoreboard players set #ml_page menu 0
execute store result score #ml_page menu run data get storage rhythm_axe:map_list page
execute if score #ml_page menu matches 1.. run scoreboard players remove #ml_page menu 1
execute store result storage rhythm_axe:map_list page int 1 run scoreboard players get #ml_page menu
function rhythm_axe:map_list/maps/list_open
