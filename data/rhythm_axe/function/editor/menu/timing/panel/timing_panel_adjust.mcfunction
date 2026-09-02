#arg:field_name,delta,min
# 时间点面板字段加减（time/bpb/tpb/judgement_scale；只改暂存 editing.temp，确认才写回）
$execute store result score #temp editor run data get storage rhythm_axe:maps.editor editing.temp.$(field_name)
$scoreboard players operation #temp editor += $(delta) const
$execute if score #temp editor matches ..$(min) run scoreboard players set #temp editor $(min)
$execute store result storage rhythm_axe:maps.editor editing.temp.$(field_name) int 1 run scoreboard players get #temp editor
data remove storage rhythm_axe:prop field_name
data remove storage rhythm_axe:prop delta
data remove storage rhythm_axe:prop min
function rhythm_axe:editor/menu/timing/panel/timing_panel
