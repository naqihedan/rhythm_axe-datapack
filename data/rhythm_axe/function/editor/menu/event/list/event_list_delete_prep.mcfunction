# 事件列表【删除】前置：点击值 = (1000+页内行)×100 + 7 → prop.index（绝对 = events_page×5+页内行）
execute store result score #temp editor run data get storage rhythm_axe:maps.editor events_page
scoreboard players set #temp_cursor editor 5
scoreboard players operation #temp editor *= #temp_cursor editor
scoreboard players operation #temp_cursor editor = #click_value editor
scoreboard players operation #temp_cursor editor /= 100 const
scoreboard players remove #temp_cursor editor 1000
scoreboard players operation #temp editor += #temp_cursor editor
data modify storage rhythm_axe:prop cursor set from storage rhythm_axe:maps.editor history_cursor
execute store result storage rhythm_axe:prop index int 1 run scoreboard players get #temp editor
function rhythm_axe:editor/menu/event/list/event_list_delete_ with storage rhythm_axe:prop
data remove storage rhythm_axe:prop cursor
data remove storage rhythm_axe:prop index
