# 确认新增时间点：从暂存 editing.temp 创建（一次历史快照）
data modify storage rhythm_axe:maps.editor op_label set value "创建时间点"
data modify storage rhythm_axe:prop time set from storage rhythm_axe:maps.editor editing.temp.time
data modify storage rhythm_axe:prop bpm set from storage rhythm_axe:maps.editor editing.temp.bpm
data modify storage rhythm_axe:prop bpb set from storage rhythm_axe:maps.editor editing.temp.bpb
data modify storage rhythm_axe:prop tpb set from storage rhythm_axe:maps.editor editing.temp.tpb
data modify storage rhythm_axe:prop judgement_scale set from storage rhythm_axe:maps.editor editing.temp.judgement_scale
function rhythm_axe:editor/timing/create
data modify storage rhythm_axe:maps.editor feedback set value "已创建时间点"
data remove storage rhythm_axe:maps.editor editing
function rhythm_axe:editor/menu/timing/list/timing_list_open
