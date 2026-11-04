# 确认新增时间点：从暂存 editing.temp 创建（一次历史快照）
data modify storage rhythm_axe:maps.editor op_label set value "创建时间点"
data modify storage rhythm_axe:prop time set from storage rhythm_axe:maps.editor editing.temp.time
data modify storage rhythm_axe:prop bpm set from storage rhythm_axe:maps.editor editing.temp.bpm
data modify storage rhythm_axe:prop bpb set from storage rhythm_axe:maps.editor editing.temp.bpb
data modify storage rhythm_axe:prop tpb set from storage rhythm_axe:maps.editor editing.temp.tpb
data modify storage rhythm_axe:prop judgement_scale set from storage rhythm_axe:maps.editor editing.temp.judgement_scale
# ★ 新增时间点也要缩放：先按「新点之前最近的时间点」继承旧 bpm/tpb 作基准
#   （面板默认值 150/8 与该点实际所属的段无关，拿它算 ratio 会整段乱缩）。
#   必须在 create 之前捕获 —— create 之后新点已在数组里，问不出「它之前那一段」的旧值。
data modify storage rhythm_axe:prop cursor set from storage rhythm_axe:maps.editor history_cursor
function rhythm_axe:editor/timing/rescale/new_ctx with storage rhythm_axe:prop
data remove storage rhythm_axe:prop cursor
# rescale/run 由 create 在 file/commit 之前调用（同一快照）
function rhythm_axe:editor/timing/create
data modify storage rhythm_axe:maps.editor feedback set value "已创建时间点"
data remove storage rhythm_axe:maps.editor editing
# ★ rescale 改过 notes[] → 必须重建世界视觉（新增时间点本身不需要；rescale 接管时由它自己 refresh）
execute unless score #rs_own editor matches 1 run function rhythm_axe:editor/timing/rescale/refresh_guard
function rhythm_axe:editor/menu/timing/list/timing_list_open
