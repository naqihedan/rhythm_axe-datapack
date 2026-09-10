# 从点击值解析时间点行号（点击值 = (1000+行序)×100 + 3，编辑列）并打开设置面板
scoreboard players operation #temp editor = #click_value editor
scoreboard players operation #temp editor /= 100 const
scoreboard players remove #temp editor 1000
data modify storage rhythm_axe:prop cursor set from storage rhythm_axe:maps.editor history_cursor
execute store result storage rhythm_axe:prop index int 1 run scoreboard players get #temp editor
function rhythm_axe:editor/menu/timing/panel/timing_panel_open with storage rhythm_axe:prop
data remove storage rhythm_axe:prop cursor
data remove storage rhythm_axe:prop index
