# 总表下一页（11702）：页号 +1，重绘
# 说明：越界由 list_open 的钳制兜底（末页点下一页会停在末页；按钮本身在末页是灰的）
scoreboard players set #ml_page menu 0
execute store result score #ml_page menu run data get storage rhythm_axe:map_list page
scoreboard players add #ml_page menu 1
execute store result storage rhythm_axe:map_list page int 1 run scoreboard players get #ml_page menu
function rhythm_axe:map_list/maps/list_open
