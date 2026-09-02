#arg:cursor,index
# 比较前一个时间点：bpm×1000 存 #temp_playhead、tpb 存 #index；bpm 不同则红线，否则比较 tps
$execute store result score #temp_playhead editor run data get storage rhythm_axe:maps.editor history[$(cursor)].timing_points[$(index)].bpm 1000
$execute store result score #index editor run data get storage rhythm_axe:maps.editor history[$(cursor)].timing_points[$(index)].tpb
execute unless score #temp editor = #temp_playhead editor run data modify storage rhythm_axe:maps.editor editing.is_red set value 1b
execute if score #temp editor = #temp_playhead editor run function rhythm_axe:editor/menu/timing/panel/timing_panel_color_tps
