# 应用时间点：更新 tick rate 与判定缩放
# 宏参数 tp_idx；当前时间点先复制到 runtime.cur_tp 供宏执行
# 注意：R/G 红线自动判断（bpm/tps 是否变化）里程碑2 细化，当前每个时间点都执行 tick rate
#arg: tp_idx
$data modify storage rhythm_axe:runtime cur_tp set from storage rhythm_axe:runtime timing_points[$(tp_idx)]
function rhythm_axe:play/timing/tick_rate with storage rhythm_axe:runtime cur_tp
# 判定缩放（缺失默认 1；data get 失败会写 0，故先 if data 保护）
scoreboard players set #judgement_scale play_state 1
$execute if data storage rhythm_axe:runtime timing_points[$(tp_idx)].judgement_scale run execute store result score #judgement_scale play_state run data get storage rhythm_axe:runtime timing_points[$(tp_idx)].judgement_scale
