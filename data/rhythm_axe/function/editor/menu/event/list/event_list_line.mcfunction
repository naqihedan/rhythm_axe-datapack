#arg:cursor,index,edit_val,copy_val,paste_val,delete_val
# 事件列表单行：时间 + [编辑][复制][粘贴][删除]，下面逐条列出指令
$tellraw @s [\
{"text":"时间:","color":"gray"},\
{"nbt":"history[$(cursor)].events[$(index)].time","storage":"rhythm_axe:maps.editor","color":"white"},\
{"text":" [编辑]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set $(edit_val)"},"hover_event":{"action":"show_text","value":"编辑这个事件"}},\
{"text":"[复制]","color":"aqua","click_event":{"action":"run_command","command":"/trigger editor_click set $(copy_val)"},"hover_event":{"action":"show_text","value":"复制事件信息"}},\
{"text":"[粘贴]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set $(paste_val)"},"hover_event":{"action":"show_text","value":"粘贴事件信息"}},\
{"text":"[删除]","color":"dark_red","click_event":{"action":"run_command","command":"/trigger editor_click set $(delete_val)"},"hover_event":{"action":"show_text","value":"删除这个事件"}}\
]
data modify storage rhythm_axe:prop cmd_index set value 0
function rhythm_axe:editor/menu/event/list/event_list_cmd_row with storage rhythm_axe:prop
data remove storage rhythm_axe:prop cmd_index
