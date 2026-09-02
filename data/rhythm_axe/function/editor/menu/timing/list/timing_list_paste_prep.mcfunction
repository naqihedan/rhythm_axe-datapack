# 时间点列表【粘贴】前置：点击值 221+行号 → prop.index
scoreboard players operation #temp editor = #click_value editor
scoreboard players remove #temp editor 221
data modify storage rhythm_axe:prop cursor set from storage rhythm_axe:maps.editor history_cursor
execute store result storage rhythm_axe:prop index int 1 run scoreboard players get #temp editor
function rhythm_axe:editor/menu/timing/list/timing_list_paste_ with storage rhythm_axe:prop
data remove storage rhythm_axe:prop cursor
data remove storage rhythm_axe:prop index
