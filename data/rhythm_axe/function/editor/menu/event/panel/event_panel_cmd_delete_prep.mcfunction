# 删除指令前奏：点击值 = (1000+指令序号)×100 + 7 → 序号 = click/100 - 1000
scoreboard players operation #temp editor = #click_value editor
scoreboard players operation #temp editor /= 100 const
scoreboard players remove #temp editor 1000
data modify storage rhythm_axe:prop cmd_target set value 0
execute store result storage rhythm_axe:prop cmd_target int 1 run scoreboard players get #temp editor
function rhythm_axe:editor/menu/event/panel/event_panel_cmd_delete_ with storage rhythm_axe:prop
data remove storage rhythm_axe:prop cmd_target
function rhythm_axe:editor/menu/event/panel/event_panel
