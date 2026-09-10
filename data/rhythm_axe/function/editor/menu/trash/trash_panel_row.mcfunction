#arg: index
# 回收站行：{标题}-{作者}-{mapid}【还原】【彻底删除】；上限 10 行（按钮值 11280/11290 + index，规范v2）
$execute unless data storage rhythm_axe:maps trash[$(index)] run return 0
execute store result score #temp editor run scoreboard players get #trash_shown editor
execute if score #temp editor matches 9.. run return 0
scoreboard players add #trash_shown editor 1
$tellraw @s ["",{"nbt":"trash[$(index)].title","storage":"rhythm_axe:maps","interpret":true,"color":"aqua"},{"text":" - ","color":"gray"},{"nbt":"trash[$(index)].artist","storage":"rhythm_axe:maps","interpret":true,"color":"aqua"},{"text":" - ","color":"gray"},{"nbt":"trash[$(index)].mapid","storage":"rhythm_axe:maps","color":"aqua"},{"text":"  ","color":"gray"},{"text":"【还原】","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 1128$(index)"},"hover_event":{"action":"show_text","value":"把谱面恢复到正式存储"}},{"text":"【彻底删除】","color":"red","click_event":{"action":"run_command","command":"/trigger editor_click set 1129$(index)"},"hover_event":{"action":"show_text","value":"从回收站永久删除"}}]
execute store result score #index editor run data get storage rhythm_axe:prop index
scoreboard players add #index editor 1
execute store result storage rhythm_axe:prop index int 1 run scoreboard players get #index editor
function rhythm_axe:editor/menu/trash/trash_panel_row with storage rhythm_axe:prop
