# 上一个事件：ref-1 存在则切换，否则提示
data modify storage rhythm_axe:prop cursor set from storage rhythm_axe:maps.editor history_cursor
execute store result score #temp_playhead editor run data get storage rhythm_axe:maps.editor editing.ref
scoreboard players remove #temp_playhead editor 1
execute if score #temp_playhead editor matches ..-1 run tellraw @s [{"text":"[编辑器] 没有上一个事件","color":"red"}]
execute if score #temp_playhead editor matches 0.. run function rhythm_axe:editor/menu/event/panel/event_panel_prev_try
data remove storage rhythm_axe:prop cursor
