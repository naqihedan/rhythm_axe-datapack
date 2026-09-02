# 时间点列表【复制】前置：点击值 211+行号 → prop.index
scoreboard players operation #temp editor = #click_value editor
scoreboard players remove #temp editor 211
data modify storage rhythm_axe:prop cursor set from storage rhythm_axe:maps.editor history_cursor
execute store result storage rhythm_axe:prop index int 1 run scoreboard players get #temp editor
function rhythm_axe:editor/menu/timing/list/timing_list_copy_ with storage rhythm_axe:prop
data remove storage rhythm_axe:prop cursor
data remove storage rhythm_axe:prop index
