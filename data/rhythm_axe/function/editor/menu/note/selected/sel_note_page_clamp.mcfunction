# 已选定列表页号钳制到最后一页
execute store result score #sel_page editor run data get storage rhythm_axe:maps.editor sel_page
scoreboard players operation #sel_page editor = #sel_pages editor
scoreboard players remove #sel_page editor 1
execute store result storage rhythm_axe:maps.editor sel_page int 1 run scoreboard players get #sel_page editor
