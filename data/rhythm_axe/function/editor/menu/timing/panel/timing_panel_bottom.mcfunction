# 时间点面板底部按钮（编辑已有时间点模式）
execute if data storage rhythm_axe:maps.editor editing.delete_armed run tellraw @s [\
{"text":"【返回面板】","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set 321"},"hover_event":{"action":"show_text","value":"取消删除"}},\
{"text":"  【确认删除】","color":"red","click_event":{"action":"run_command","command":"/trigger editor_click set 318"},"hover_event":{"action":"show_text","value":"删除这个时间点"}}\
]
execute unless data storage rhythm_axe:maps.editor editing.delete_armed run tellraw @s [\
{"text":"【取消】","color":"red","click_event":{"action":"run_command","command":"/trigger editor_click set 320"},"hover_event":{"action":"show_text","value":"丢弃修改并返回列表"}},\
{"text":"  【确认】","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 316"},"hover_event":{"action":"show_text","value":"把修改写回谱面（可撤销）"}},\
{"text":"  【复制】","color":"aqua","click_event":{"action":"run_command","command":"/trigger editor_click set 322"},"hover_event":{"action":"show_text","value":"复制正在编辑的时间点信息"}},\
{"text":"  【粘贴】","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set 323"},"hover_event":{"action":"show_text","value":"粘贴剪贴板信息到正在编辑的时间点"}},\
{"text":"  【删除】","color":"dark_red","click_event":{"action":"run_command","command":"/trigger editor_click set 317"},"hover_event":{"action":"show_text","value":"删除这个时间点"}}\
]
