# 上一个事件按钮（#temp_playhead = ref-1，宏展开判断存在）
data modify storage rhythm_axe:prop cursor set from storage rhythm_axe:maps.editor history_cursor
execute store result storage rhythm_axe:prop index int 1 run scoreboard players get #temp_playhead editor
function rhythm_axe:editor/menu/event/panel/event_panel_nav_prev_ with storage rhythm_axe:prop
data remove storage rhythm_axe:prop cursor
data remove storage rhythm_axe:prop index
