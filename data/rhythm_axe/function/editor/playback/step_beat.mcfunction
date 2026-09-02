# 跳一拍：ticks = 当前时间点 tpb
function rhythm_axe:editor/playback/current_timing
execute store result score #step_ticks editor run data get storage rhythm_axe:prop tpb
execute store result storage rhythm_axe:prop ticks int 1 run scoreboard players get #step_ticks editor
function rhythm_axe:editor/playback/seek
