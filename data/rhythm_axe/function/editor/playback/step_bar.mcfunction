# 跳一小节：ticks = 当前时间点 tpb × bpb
function rhythm_axe:editor/playback/current_timing
execute store result score #step_ticks editor run data get storage rhythm_axe:prop tpb
execute store result score #beats_per_bar editor run data get storage rhythm_axe:prop bpb
scoreboard players operation #step_ticks editor *= #beats_per_bar editor
execute store result storage rhythm_axe:prop ticks int 1 run scoreboard players get #step_ticks editor
function rhythm_axe:editor/playback/seek
