# 事件面板底部按钮（编辑已有事件点模式）
execute if data storage rhythm_axe:maps.editor editing.delete_armed run tellraw @s [\
{"text":"【返回面板】","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set 508"},"hover_event":{"action":"show_text","value":"取消删除"}},\
{"text":"  【确认删除】","color":"red","click_event":{"action":"run_command","command":"/trigger editor_click set 507"},"hover_event":{"action":"show_text","value":"删除这个事件点"}}\
]
execute unless data storage rhythm_axe:maps.editor editing.delete_armed run tellraw @s [\
{"text":"【取消】","color":"red","click_event":{"action":"run_command","command":"/trigger editor_click set 503"},"hover_event":{"action":"show_text","value":"丢弃修改并返回列表"}},\
{"text":"  【确认】","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 504"},"hover_event":{"action":"show_text","value":"把修改写回谱面（可撤销）"}},\
{"text":"  【复制】","color":"aqua","click_event":{"action":"run_command","command":"/trigger editor_click set 591"},"hover_event":{"action":"show_text","value":"复制正在编辑的事件信息"}},\
{"text":"  【粘贴】","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set 592"},"hover_event":{"action":"show_text","value":"粘贴剪贴板信息到正在编辑的事件"}},\
{"text":"  【删除】","color":"dark_red","click_event":{"action":"run_command","command":"/trigger editor_click set 505"},"hover_event":{"action":"show_text","value":"删除这个事件点"}}\
]
