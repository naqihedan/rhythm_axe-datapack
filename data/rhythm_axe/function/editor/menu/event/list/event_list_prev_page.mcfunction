# 上一页：page-1（>=0）后重开列表
execute store result score #event_page editor run data get storage rhythm_axe:maps.editor events_page
execute if score #event_page editor matches 1.. run scoreboard players remove #event_page editor 1
execute store result storage rhythm_axe:maps.editor events_page int 1 run scoreboard players get #event_page editor
function rhythm_axe:editor/menu/event/list/event_list_open
