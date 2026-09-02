#arg:cmd_index,edit_val,delete_val
# 事件指令单行：编号 + 命令字符串 + 编辑/删除按钮
$tellraw @s [\
{"text":"指令#","color":"gray"},\
{"score":{"name":"#temp_playhead","objective":"editor"},"color":"white"},\
{"text":"： ","color":"gray"},\
{"nbt":"editing.temp.commands[$(cmd_index)]","storage":"rhythm_axe:maps.editor","color":"white"},\
{"text":" 【编辑指令】","color":"aqua","click_event":{"action":"run_command","command":"/trigger editor_click set $(edit_val)"},"hover_event":{"action":"show_text","value":"对话框编辑这条指令"}},\
{"text":" 【删除】","color":"red","click_event":{"action":"run_command","command":"/trigger editor_click set $(delete_val)"},"hover_event":{"action":"show_text","value":"删除这条指令"}}\
]
