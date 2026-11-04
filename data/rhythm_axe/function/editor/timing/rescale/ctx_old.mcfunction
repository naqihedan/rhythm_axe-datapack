#arg:cursor,index
# 捕获缩放上下文·第一部分：旧 bpm/tpb（★ 必须在动时间点之前调用）
# 前置：prop.cursor、prop.index（被改时间点的下标）
# 输出：prop.rescale={bpm_old,tpb_old}（a 由 ctx_new 在写回后按新 time 定）
# ★ 只负责「旧值」；锚点 a 与边界 b 由 ctx_new / new_ctx 在写回（新点已落位）之后算。
data modify storage rhythm_axe:prop rescale set value {a:0,bpm_old:150.0f,tpb_old:8}
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].timing_points[$(index)] run data modify storage rhythm_axe:prop rescale.bpm_old set from storage rhythm_axe:maps.editor history[$(cursor)].timing_points[$(index)].bpm
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].timing_points[$(index)] run data modify storage rhythm_axe:prop rescale.tpb_old set from storage rhythm_axe:maps.editor history[$(cursor)].timing_points[$(index)].tpb
# 旧时间点可能缺字段 → 按谱面默认值兜底（bpm 150 / tpb 8）
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].timing_points[$(index)] unless data storage rhythm_axe:maps.editor history[$(cursor)].timing_points[$(index)].bpm run data modify storage rhythm_axe:prop rescale.bpm_old set value 150.0f
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].timing_points[$(index)] unless data storage rhythm_axe:maps.editor history[$(cursor)].timing_points[$(index)].tpb run data modify storage rhythm_axe:prop rescale.tpb_old set value 8