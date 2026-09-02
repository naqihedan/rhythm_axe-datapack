#arg:cursor,index
# 找"上一个时间点"的叶子（宏）：当前存在且 time <= playhead → 视为候选，写入候选记录。
# 用于时间点工具继承：取 time <= 播放头 且 time 最大的那个时间点的全部字段。
# 结果写入 prop：inherit_bpm/inherit_bpb/inherit_tpb/inherit_judgement_scale（命中时）
# #inh_done：1=命中（含候选更新） 2=元素缺失=遍历结束 0=继续
$execute unless data storage rhythm_axe:maps.editor history[$(cursor)].timing_points[$(index)] run scoreboard players set #inh_done editor 2
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].timing_points[$(index)] run execute store result score #elem_time editor run data get storage rhythm_axe:maps.editor history[$(cursor)].timing_points[$(index)].time
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].timing_points[$(index)] run execute store result score #inh_playhead editor run data get storage rhythm_axe:prop inherit_playhead
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].timing_points[$(index)] if score #elem_time editor <= #inh_playhead editor run data modify storage rhythm_axe:prop inh_bpm set from storage rhythm_axe:maps.editor history[$(cursor)].timing_points[$(index)].bpm
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].timing_points[$(index)] if score #elem_time editor <= #inh_playhead editor run data modify storage rhythm_axe:prop inh_bpb set from storage rhythm_axe:maps.editor history[$(cursor)].timing_points[$(index)].bpb
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].timing_points[$(index)] if score #elem_time editor <= #inh_playhead editor run data modify storage rhythm_axe:prop inh_tpb set from storage rhythm_axe:maps.editor history[$(cursor)].timing_points[$(index)].tpb
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].timing_points[$(index)] if score #elem_time editor <= #inh_playhead editor run data modify storage rhythm_axe:prop inh_judgement_scale set from storage rhythm_axe:maps.editor history[$(cursor)].timing_points[$(index)].judgement_scale
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].timing_points[$(index)] if score #elem_time editor <= #inh_playhead editor run scoreboard players set #inh_found editor 1
