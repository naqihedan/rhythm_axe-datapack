# 事件点设置面板：显示暂存 editing.temp 的时间与指令列表
function rhythm_axe:editor/menu/clear_lines
function rhythm_axe:editor/menu/show_feedback
tellraw @s [{"text":"====事件点设置====","color":"gold","bold":true}]
# 时间行（下限 0）
execute store result score #temp editor run data get storage rhythm_axe:maps.editor editing.temp.time
execute if score #temp editor matches ..0 run tellraw @s [\
{"text":"时间：","color":"gray"},\
{"text":"[-]","color":"red","click_event":{"action":"run_command","command":"/trigger editor_click set 500"},"hover_event":{"action":"show_text","value":"最少 0 刻"}},\
{"nbt":"editing.temp.time","storage":"rhythm_axe:maps.editor","color":"white"},\
{"text":" [+] ","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 501"},"hover_event":{"action":"show_text","value":"时间 +1 刻"}},\
{"text":"【使用当前时间】","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set 590"},"hover_event":{"action":"show_text","value":"时间设为播放头位置"}}\
]
execute if score #temp editor matches 1.. run tellraw @s [\
{"text":"时间：","color":"gray"},\
{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 500"},"hover_event":{"action":"show_text","value":"时间 -1 刻"}},\
{"nbt":"editing.temp.time","storage":"rhythm_axe:maps.editor","color":"white"},\
{"text":" [+] ","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 501"},"hover_event":{"action":"show_text","value":"时间 +1 刻"}},\
{"text":"【使用当前时间】","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set 590"},"hover_event":{"action":"show_text","value":"时间设为播放头位置"}}\
]
# 指令行遍历
data modify storage rhythm_axe:prop cmd_index set value 0
function rhythm_axe:editor/menu/event/panel/event_panel_cmd_row with storage rhythm_axe:prop
data remove storage rhythm_axe:prop cmd_index
data remove storage rhythm_axe:prop edit_val
data remove storage rhythm_axe:prop delete_val
# 添加指令
tellraw @s [{"text":"【添加一个指令】","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 502"},"hover_event":{"action":"show_text","value":"在末尾追加一条空指令"}}]
# 上一个/下一个事件
function rhythm_axe:editor/menu/event/panel/event_panel_nav
# 底部按钮（按模式）
execute unless data storage rhythm_axe:maps.editor editing.is_new run function rhythm_axe:editor/menu/event/panel/event_panel_bottom
execute if data storage rhythm_axe:maps.editor editing.is_new run tellraw @s [\
{"text":"【取消】","color":"red","click_event":{"action":"run_command","command":"/trigger editor_click set 503"},"hover_event":{"action":"show_text","value":"丢弃修改并返回列表"}},\
{"text":"  【确认新增】","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 506"},"hover_event":{"action":"show_text","value":"在指定时间新增事件点"}},\
{"text":"  【复制】","color":"aqua","click_event":{"action":"run_command","command":"/trigger editor_click set 591"},"hover_event":{"action":"show_text","value":"复制正在编辑的事件信息"}},\
{"text":"  【粘贴】","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set 592"},"hover_event":{"action":"show_text","value":"粘贴剪贴板信息到正在编辑的事件"}}\
]
