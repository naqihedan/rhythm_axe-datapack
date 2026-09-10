#arg:cursor,index
# 上一个事件按钮：存在则绿色可点，不存在则红色
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].events[$(index)] run tellraw @s [{"text":"【上一个事件】","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 10409"},"hover_event":{"action":"show_text","value":"跳到上一个事件"}}]
$execute unless data storage rhythm_axe:maps.editor history[$(cursor)].events[$(index)] run tellraw @s [{"text":"【上一个事件】","color":"red"}]
