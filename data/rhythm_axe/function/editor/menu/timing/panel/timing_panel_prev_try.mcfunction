# 检查 ref-1 是否存在并切换
execute store result storage rhythm_axe:prop index int 1 run scoreboard players get #temp_playhead editor
function rhythm_axe:editor/menu/timing/panel/timing_panel_prev_try_ with storage rhythm_axe:prop
data remove storage rhythm_axe:prop index
data remove storage rhythm_axe:prop cursor
