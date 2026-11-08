# 空指令查找驱动器（普通函数递归；下标存 prop.fe_i，终止标志 #fe_done）
scoreboard players set #fe_done editor 0
execute store result storage rhythm_axe:prop fe_i int 1 run scoreboard players get #fe_i editor
function rhythm_axe:editor/menu/event/panel/event_panel_find_empty_leaf with storage rhythm_axe:prop
execute if score #fe_done editor matches 1 run return 0
scoreboard players add #fe_i editor 1
# 上限保护（正常谱面指令数远小于此）
execute if score #fe_i editor matches 500.. run return 0
function rhythm_axe:editor/menu/event/panel/event_panel_find_empty_drive