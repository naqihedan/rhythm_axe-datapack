# 页码钳制：page 超出范围时设为最后一页
scoreboard players operation #event_page editor = #event_pages editor
scoreboard players remove #event_page editor 1
execute store result storage rhythm_axe:maps.editor events_page int 1 run scoreboard players get #event_page editor
