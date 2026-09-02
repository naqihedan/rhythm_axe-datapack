# bpm 相同，比较 tps（bpm×tpb）：不同则红线，相同则绿线
scoreboard players operation #temp_playhead editor *= #index editor
execute unless score #temp_cursor editor = #temp_playhead editor run data modify storage rhythm_axe:maps.editor editing.is_red set value 1b
execute if score #temp_cursor editor = #temp_playhead editor run data modify storage rhythm_axe:maps.editor editing.is_red set value 0b
