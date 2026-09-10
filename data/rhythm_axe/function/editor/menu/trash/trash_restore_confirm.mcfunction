#arg: mapid
# 还原覆盖确认面板：目标谱面已存在 → 【覆盖已有谱面】11270 / 【取消】11271
data modify storage rhythm_axe:maps.editor current_panel set value 17
tellraw @s [{"text":"====回收站====","color":"gold","bold":true}]
$tellraw @s ["",{"text":"有同 mapid 的谱面（","color":"yellow"},{"text":"$(mapid)","color":"aqua"},{"text":"）已存在，现在要进行的操作？","color":"yellow"}]
tellraw @s [{"text":"【覆盖已有谱面】","color":"red","click_event":{"action":"run_command","command":"/trigger editor_click set 11270"},"hover_event":{"action":"show_text","value":"用回收站内容覆盖现有谱面"}},{"text":"  【取消】","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 11271"},"hover_event":{"action":"show_text","value":"返回回收站"}}]
