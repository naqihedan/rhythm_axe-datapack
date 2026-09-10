# 从点击值解析事件行号（点击值 = (1000+页内行)×100 + 3；真实索引 = events_page×5 + 页内行）并打开设置面板
scoreboard players operation #temp editor = #click_value editor
scoreboard players operation #temp editor /= 100 const
scoreboard players remove #temp editor 1000
execute store result score #temp_playhead editor run data get storage rhythm_axe:maps.editor events_page
scoreboard players set #index editor 5
scoreboard players operation #temp_playhead editor *= #index editor
scoreboard players operation #temp editor += #temp_playhead editor
data modify storage rhythm_axe:prop cursor set from storage rhythm_axe:maps.editor history_cursor
execute store result storage rhythm_axe:prop index int 1 run scoreboard players get #temp editor
function rhythm_axe:editor/menu/event/panel/event_panel_open with storage rhythm_axe:prop
data remove storage rhythm_axe:prop cursor
data remove storage rhythm_axe:prop index
