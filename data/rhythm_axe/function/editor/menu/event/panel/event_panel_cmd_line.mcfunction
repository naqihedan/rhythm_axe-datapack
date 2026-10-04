#arg:cmd_index,edit_val,copy_val,paste_val,delete_val,up_val,down_val
# 事件指令单行：[↑][↓][✏️][📋][📌][🗑️] #N：指令
# 指令剪贴板为空时【📌】变红（点它只提示先复制）
$execute if data storage rhythm_axe:maps.editor cmd_clip run tellraw @s [\
{"text":"[↑]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set $(up_val)"},"hover_event":{"action":"show_text","value":"上移一行"}},\
{"text":"[↓]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set $(down_val)"},"hover_event":{"action":"show_text","value":"下移一行"}},\
{"text":"[✏]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set $(edit_val)"},"hover_event":{"action":"show_text","value":"编辑这条指令"}},\
{"text":"[📋]","color":"aqua","click_event":{"action":"run_command","command":"/trigger editor_click set $(copy_val)"},"hover_event":{"action":"show_text","value":"复制这条指令"}},\
{"text":"[📌]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set $(paste_val)"},"hover_event":{"action":"show_text","value":"粘贴到这一行"}},\
{"text":"[🗑]","color":"dark_red","click_event":{"action":"run_command","command":"/trigger editor_click set $(delete_val)"},"hover_event":{"action":"show_text","value":"删除这条指令"}},\
{"text":" #","color":"gray"},\
{"score":{"name":"#temp_playhead","objective":"editor"},"color":"white"},\
{"text":"：","color":"gray"},\
{"nbt":"editing.temp.commands[$(cmd_index)]","storage":"rhythm_axe:maps.editor","color":"white"}\
]
$execute unless data storage rhythm_axe:maps.editor cmd_clip run tellraw @s [\
{"text":"[↑]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set $(up_val)"},"hover_event":{"action":"show_text","value":"上移一行"}},\
{"text":"[↓]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set $(down_val)"},"hover_event":{"action":"show_text","value":"下移一行"}},\
{"text":"[✏]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set $(edit_val)"},"hover_event":{"action":"show_text","value":"编辑这条指令"}},\
{"text":"[📋]","color":"aqua","click_event":{"action":"run_command","command":"/trigger editor_click set $(copy_val)"},"hover_event":{"action":"show_text","value":"复制这条指令"}},\
{"text":"[📌]","color":"red","click_event":{"action":"run_command","command":"/trigger editor_click set $(paste_val)"},"hover_event":{"action":"show_text","value":"剪贴板为空，先复制一条指令"}},\
{"text":"[🗑]","color":"dark_red","click_event":{"action":"run_command","command":"/trigger editor_click set $(delete_val)"},"hover_event":{"action":"show_text","value":"删除这条指令"}},\
{"text":" #","color":"gray"},\
{"score":{"name":"#temp_playhead","objective":"editor"},"color":"white"},\
{"text":"：","color":"gray"},\
{"nbt":"editing.temp.commands[$(cmd_index)]","storage":"rhythm_axe:maps.editor","color":"white"}\
]
