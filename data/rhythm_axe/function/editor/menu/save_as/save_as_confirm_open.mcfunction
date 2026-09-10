# 另存为确认面板：有未保存内容
function rhythm_axe:editor/menu/clear_lines
data modify storage rhythm_axe:maps.editor current_panel set value 9
tellraw @s [{"text":"====另存为新谱面====","color":"gold","bold":true}]
tellraw @s [{"text":"当前有未保存的内容，另存前要保存吗？","color":"yellow"}]
tellraw @s [\
{"text":"【保存后另存】","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 10001"},"hover_event":{"action":"show_text","value":"先保存当前谱面再另存"}},\
{"text":"  【直接另存】","color":"red","click_event":{"action":"run_command","command":"/trigger editor_click set 10002"},"hover_event":{"action":"show_text","value":"丢弃未保存修改，另存当前内容"}},\
{"text":"  【返回】","color":"gray","click_event":{"action":"run_command","command":"/trigger editor_click set 10003"},"hover_event":{"action":"show_text","value":"回到主菜单"}}\
]
