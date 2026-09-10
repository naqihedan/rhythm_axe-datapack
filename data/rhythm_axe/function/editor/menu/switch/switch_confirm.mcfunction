# 切换谱面确认面板（面板 15）：显示当前谱面信息，按未保存与否给两版按钮
# 值段：10001 保存并切换 / 10002 丢弃并切换 / 10003 编辑新谱面 / 903 继续编辑当前谱面
function rhythm_axe:editor/menu/clear_lines
function rhythm_axe:editor/menu/show_feedback
data modify storage rhythm_axe:maps.editor current_panel set value 15
tellraw @s [{"text":"====切换谱面====","color":"gold","bold":true}]
# 当前谱面信息行（标题-作者，mapid）
data modify storage rhythm_axe:prop cursor set from storage rhythm_axe:maps.editor history_cursor
function rhythm_axe:editor/menu/switch/switch_title with storage rhythm_axe:prop
data remove storage rhythm_axe:prop cursor
tellraw @s [{"text":"要退出当前编辑吗？","color":"yellow"}]
# 未保存判断：history_cursor != saved_cursor → 有未保存
execute store result score #temp_cursor editor run data get storage rhythm_axe:maps.editor history_cursor
execute store result score #temp editor run data get storage rhythm_axe:maps.editor saved_cursor
# 有未保存内容：保存并切换 / 丢弃并切换 / 继续编辑
execute unless score #temp_cursor editor = #temp editor run tellraw @s [\
{"text":"【保存当前谱面并开始编辑新谱面】","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 10001"},"hover_event":{"action":"show_text","value":"保存当前谱面后打开新谱面"}},\
{"text":"  【丢弃当前谱面改动并且开始编辑新谱面】","color":"red","click_event":{"action":"run_command","command":"/trigger editor_click set 10002"},"hover_event":{"action":"show_text","value":"不保存当前改动，直接打开新谱面"}},\
{"text":"  【继续编辑当前谱面】","color":"gray","click_event":{"action":"run_command","command":"/trigger editor_click set 903"},"hover_event":{"action":"show_text","value":"回到当前谱面编辑器"}}\
]
# 无未保存内容：编辑新谱面 / 继续编辑
execute if score #temp_cursor editor = #temp editor run tellraw @s [\
{"text":"【编辑新谱面】","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 10003"},"hover_event":{"action":"show_text","value":"直接打开新谱面"}},\
{"text":"  【继续编辑当前谱面】","color":"gray","click_event":{"action":"run_command","command":"/trigger editor_click set 903"},"hover_event":{"action":"show_text","value":"回到当前谱面编辑器"}}\
]
