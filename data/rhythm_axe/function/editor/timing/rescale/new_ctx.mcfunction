#arg:time,bpm,tpb,cursor
# 新增时间点的缩放上下文：以「新点之前最近的时间点」为旧基准，锚 = 新点 time。
# 前置：prop.time（新点时间）、prop.tpb（新 tpb）、prop.bpm（新 bpm）、prop.cursor
# 输出：prop.rescale = {a, b?, bpm_old, tpb_old, bpm_new, tpb_new}
#   缺 b（新点是最后一个）⇒ 该段延伸到谱尾，不写 b 键。
#
# ★ 为什么不能直接用面板默认值（150/8）当旧值：新点的实际「前一段」是继承来的
#   （见 tool/timing_inherit），面板默认只在新谱面第一点上才等于继承值。
# ★ 插入位置用 insert_find 的同一口径（首个 time > 新 time 的下标），
#   这样「b」= 新点插入后会紧跟其后的那个时间点。
data modify storage rhythm_axe:prop rescale set value {a:0,bpm_old:150.0f,tpb_old:8}
# a = 新点时间
data modify storage rhythm_axe:prop rescale.a set from storage rhythm_axe:prop time
# 旧 bpm/tpb = 新点之前最近的时间点（找不到则用默认 150 / 8）
data modify storage rhythm_axe:prop inherit_playhead set from storage rhythm_axe:prop time
data modify storage rhythm_axe:prop index set value 0
scoreboard players set #inh_found editor 0
scoreboard players set #inh_done editor 0
function rhythm_axe:editor/tool/timing_inherit
execute if score #inh_found editor matches 1 run data modify storage rhythm_axe:prop rescale.bpm_old set from storage rhythm_axe:prop inh_bpm
execute if score #inh_found editor matches 1 run data modify storage rhythm_axe:prop rescale.tpb_old set from storage rhythm_axe:prop inh_tpb
data remove storage rhythm_axe:prop inherit_playhead
data remove storage rhythm_axe:prop inh_bpm
data remove storage rhythm_axe:prop inh_bpb
data remove storage rhythm_axe:prop inh_tpb
data remove storage rhythm_axe:prop inh_judgement_scale
# b = 插入位置处原本的那个时间点（= 新点的下一个）
data modify storage rhythm_axe:prop new_time set from storage rhythm_axe:prop time
data remove storage rhythm_axe:prop insert_mode
data remove storage rhythm_axe:prop insert_index
data remove storage rhythm_axe:prop index
data modify storage rhythm_axe:prop list_name set value "timing_points"
data modify storage rhythm_axe:prop index set value 0
function rhythm_axe:editor/util/insert_find with storage rhythm_axe:prop
# insert_find 输出 prop.index（= 首个 time > 新 time 的下标 = 新点插入后其后的那个元素）
execute store result storage rhythm_axe:prop j int 1 run data get storage rhythm_axe:prop index 1
function rhythm_axe:editor/timing/rescale/ctx_next with storage rhythm_axe:prop
# 新值
data modify storage rhythm_axe:prop rescale.bpm_new set from storage rhythm_axe:prop bpm
data modify storage rhythm_axe:prop rescale.tpb_new set from storage rhythm_axe:prop tpb
data remove storage rhythm_axe:prop new_time
data remove storage rhythm_axe:prop list_name
data remove storage rhythm_axe:prop insert_mode
data remove storage rhythm_axe:prop insert_index
data remove storage rhythm_axe:prop j