#arg:cursor,index,cmd_index
# 事件指令单行（带引号显示）
$tellraw @s [\
{"text":" \"","color":"gray"},\
{"nbt":"history[$(cursor)].events[$(index)].commands[$(cmd_index)]","storage":"rhythm_axe:maps.editor","color":"white"},\
{"text":"\"","color":"gray"}\
]
