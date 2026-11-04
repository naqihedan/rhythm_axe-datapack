# 编辑时间点·缩放上下文（★ 在时间点已写回工作副本之后调用）
# 前置：prop.cursor、prop.rescale.bpm_old/tpb_old（由 ctx_old 在写回前捕获）
# 输出：prop.rescale.a（新起点）、prop.rescale.b（新起点之后的第一个时间点，可能缺）、
#       prop.rescale.bpm_new / tpb_new
#
# ★ 为什么锚点用「新 time」而不是「旧 time」：用户在同一个面板里可能既改 tpb 又把时间拖走，
#   此时旧起点已经不代表这张谱面的段结构了；以新起点为锚才能保证「同段内 → 按比例」的语义。
# ★ 边界 b 用 insert_find 的等值靠后语义重算：给出「第一个 time > a」的时间点，
#   若 a 本身就是那个时间点（改的是它自己），结果正好跳过自己。
data modify storage rhythm_axe:prop rescale.a set from storage rhythm_axe:maps.editor editing.temp.time
data modify storage rhythm_axe:prop rescale.bpm_new set from storage rhythm_axe:maps.editor editing.temp.bpm
data modify storage rhythm_axe:prop rescale.tpb_new set from storage rhythm_axe:maps.editor editing.temp.tpb
data remove storage rhythm_axe:prop rescale.b
# b = 第一个 time > a 的时间点（用 insert_find：输出 prop.index / insert_mode）
data modify storage rhythm_axe:prop new_time set from storage rhythm_axe:prop rescale.a
data modify storage rhythm_axe:prop list_name set value "timing_points"
data remove storage rhythm_axe:prop insert_mode
data remove storage rhythm_axe:prop insert_index
data modify storage rhythm_axe:prop index set value 0
function rhythm_axe:editor/util/insert_find with storage rhythm_axe:prop
execute store result storage rhythm_axe:prop j int 1 run data get storage rhythm_axe:prop index 1
function rhythm_axe:editor/timing/rescale/ctx_next with storage rhythm_axe:prop
data remove storage rhythm_axe:prop new_time
data remove storage rhythm_axe:prop list_name
data remove storage rhythm_axe:prop insert_mode
data remove storage rhythm_axe:prop insert_index
data remove storage rhythm_axe:prop index
data remove storage rhythm_axe:prop j