# 查找面板：选择要查找的类型
function rhythm_axe:editor/menu/clear_lines
data modify storage rhythm_axe:maps.editor current_panel set value 7
tellraw @s [{"text":"====查找====","color":"gold","bold":true}]
tellraw @s [\
{"text":"【时间点】","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 10001"},"hover_event":{"action":"show_text","value":"按时间查找时间点"}},\
{"text":"  【事件点】","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 10002"},"hover_event":{"action":"show_text","value":"按时间查找事件点"}},\
{"text":"  【音符】","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 10003"},"hover_event":{"action":"show_text","value":"按 id 查找音符"}}\
]
tellraw @s [{"text":"【返回】","color":"gray","click_event":{"action":"run_command","command":"/trigger editor_click set 1"},"hover_event":{"action":"show_text","value":"返回主菜单"}}]
