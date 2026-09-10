#arg: mapid
# 彻底删除二次确认面板：【彻底删除】11272 / 【取消】11273
data modify storage rhythm_axe:maps.editor current_panel set value 17
tellraw @s [{"text":"====回收站====","color":"gold","bold":true}]
$tellraw @s ["",{"text":"确定要彻底删除","color":"red"},{"text":"$(mapid)","color":"aqua"},{"text":"？此操作不可恢复","color":"red"}]
tellraw @s [{"text":"【彻底删除】","color":"red","click_event":{"action":"run_command","command":"/trigger editor_click set 11272"},"hover_event":{"action":"show_text","value":"从回收站永久删除"}},{"text":"  【取消】","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 11273"},"hover_event":{"action":"show_text","value":"返回回收站"}}]
