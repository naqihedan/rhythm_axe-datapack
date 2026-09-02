#arg:cursor,index,prev
# 列表行颜色（bpm 相同）：比较 tps（bpm×tpb×1000）；绿线不写键（row 已清空 is_red）
$execute store result score #temp_cursor editor run data get storage rhythm_axe:maps.editor history[$(cursor)].timing_points[$(index)].bpm 1000
$execute store result score #temp editor run data get storage rhythm_axe:maps.editor history[$(cursor)].timing_points[$(index)].tpb
scoreboard players operation #temp_cursor editor *= #temp editor
$execute store result score #temp_playhead editor run data get storage rhythm_axe:maps.editor history[$(cursor)].timing_points[$(prev)].bpm 1000
$execute store result score #temp editor run data get storage rhythm_axe:maps.editor history[$(cursor)].timing_points[$(prev)].tpb
scoreboard players operation #temp_playhead editor *= #temp editor
execute unless score #temp_cursor editor = #temp_playhead editor run data modify storage rhythm_axe:prop is_red set value 1b
