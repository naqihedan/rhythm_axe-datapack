# 退出确认面板：有未保存内容，选择是否保存
function rhythm_axe:editor/menu/clear_lines
data modify storage rhythm_axe:maps.editor current_panel set value 8
tellraw @s [{"text":"====退出编辑器====","color":"gold","bold":true}]
tellraw @s [{"text":"有未保存的内容，退出前要保存吗？","color":"yellow"}]
tellraw @s [\
{"text":"【保存并退出】","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 10001"},"hover_event":{"action":"show_text","value":"保存谱面后退出"}},\
{"text":"  【不保存并退出】","color":"red","click_event":{"action":"run_command","command":"/trigger editor_click set 10002"},"hover_event":{"action":"show_text","value":"丢弃未保存的修改并退出"}},\
{"text":"  【返回编辑器】","color":"gray","click_event":{"action":"run_command","command":"/trigger editor_click set 903"},"hover_event":{"action":"show_text","value":"回到编辑器"}}\
]
