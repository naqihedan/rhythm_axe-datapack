#arg:cursor,index,prev
# 列表行颜色：当前与前一时间点 bpm 不同 → 红；相同再比较 tps
$execute store result score #temp_cursor editor run data get storage rhythm_axe:maps.editor history[$(cursor)].timing_points[$(index)].bpm 1000
$execute store result score #temp_playhead editor run data get storage rhythm_axe:maps.editor history[$(cursor)].timing_points[$(prev)].bpm 1000
execute unless score #temp_cursor editor = #temp_playhead editor run data modify storage rhythm_axe:prop is_red set value 1b
execute if score #temp_cursor editor = #temp_playhead editor run function rhythm_axe:editor/menu/timing/list/timing_list_line_color_tps with storage rhythm_axe:prop
