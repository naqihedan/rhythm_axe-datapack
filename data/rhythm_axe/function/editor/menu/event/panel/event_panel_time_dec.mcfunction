# 时间 -1（只改暂存 editing.temp，clamp ≥0）
execute store result score #temp editor run data get storage rhythm_axe:maps.editor editing.temp.time
scoreboard players remove #temp editor 1
execute if score #temp editor matches ..-1 run scoreboard players set #temp editor 0
execute store result storage rhythm_axe:maps.editor editing.temp.time int 1 run scoreboard players get #temp editor
function rhythm_axe:editor/menu/event/panel/event_panel
