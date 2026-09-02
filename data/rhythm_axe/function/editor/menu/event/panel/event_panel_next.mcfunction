# 下一个事件：ref+1 存在则切换，否则提示
data modify storage rhythm_axe:prop cursor set from storage rhythm_axe:maps.editor history_cursor
execute store result score #temp_playhead editor run data get storage rhythm_axe:maps.editor editing.ref
scoreboard players add #temp_playhead editor 1
execute store result storage rhythm_axe:prop index int 1 run scoreboard players get #temp_playhead editor
function rhythm_axe:editor/menu/event/panel/event_panel_next_try_ with storage rhythm_axe:prop
data remove storage rhythm_axe:prop cursor
data remove storage rhythm_axe:prop index
