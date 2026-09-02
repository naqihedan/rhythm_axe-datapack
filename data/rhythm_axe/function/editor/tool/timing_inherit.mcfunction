# 时间点工具继承：找出 time <= 播放头 且 time 最大的时间点，复制其 bpm/bpb/tpb/judgement_scale 到 prop.inh_*。
# 前置：调用方须先 prop.cursor（history 游标）、prop.inherit_playhead（播放头）、prop.index=0、#inh_found=0、#inh_done=0。
# 命中写 #inh_found=1 并填 prop.inh_*；未命中则不写（由调用方用默认值兜底）。
# 普通函数驱动，规避 26.x 宏递归"幽灵重跑"。★ 本函数体内【绝不】重置 index/标志，否则递归无限循环。
function rhythm_axe:editor/tool/timing_inherit_leaf with storage rhythm_axe:prop
execute if score #inh_done editor matches 2 run return 0
execute if score #inh_done editor matches 1 run return 0
# 递增索引继续
execute store result score #index editor run data get storage rhythm_axe:prop index
scoreboard players add #index editor 1
execute store result storage rhythm_axe:prop index int 1 run scoreboard players get #index editor
function rhythm_axe:editor/tool/timing_inherit
