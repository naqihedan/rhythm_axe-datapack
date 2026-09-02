#arg:cursor,index
# 递归：从 timing_points[$(index)] 向后找播放头所在段；time > playhead 或索引不存在 → 保留上一段记录
# ★ 首轮（index=0）先记第一个时间点作默认：playhead 早于首个时间点（返回开头）时 tickrate_ 也有 bpm
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].timing_points[0].bpm run data modify storage rhythm_axe:prop bpm set from storage rhythm_axe:maps.editor history[$(cursor)].timing_points[0].bpm
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].timing_points[0].tpb run data modify storage rhythm_axe:prop tpb set from storage rhythm_axe:maps.editor history[$(cursor)].timing_points[0].tpb
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].timing_points[0].bpb run data modify storage rhythm_axe:prop bpb set from storage rhythm_axe:maps.editor history[$(cursor)].timing_points[0].bpb
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].timing_points[0].time run data modify storage rhythm_axe:prop time set from storage rhythm_axe:maps.editor history[$(cursor)].timing_points[0].time
$execute unless data storage rhythm_axe:maps.editor history[$(cursor)].timing_points[$(index)] run return 0
$execute store result score #timing_time editor run data get storage rhythm_axe:maps.editor history[$(cursor)].timing_points[$(index)].time
execute store result score #temp_playhead editor run data get storage rhythm_axe:prop playhead
execute if score #timing_time editor > #temp_playhead editor run return 0
$data modify storage rhythm_axe:prop bpm set from storage rhythm_axe:maps.editor history[$(cursor)].timing_points[$(index)].bpm
$data modify storage rhythm_axe:prop tpb set from storage rhythm_axe:maps.editor history[$(cursor)].timing_points[$(index)].tpb
$data modify storage rhythm_axe:prop bpb set from storage rhythm_axe:maps.editor history[$(cursor)].timing_points[$(index)].bpb
$data modify storage rhythm_axe:prop time set from storage rhythm_axe:maps.editor history[$(cursor)].timing_points[$(index)].time
execute store result score #index editor run data get storage rhythm_axe:prop index
scoreboard players add #index editor 1
execute store result storage rhythm_axe:prop index int 1 run scoreboard players get #index editor
function rhythm_axe:editor/playback/current_timing_ with storage rhythm_axe:prop
