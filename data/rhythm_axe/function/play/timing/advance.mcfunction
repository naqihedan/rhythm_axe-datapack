# timing_point 推进：若 #timing_cursor 指向的时间点 time == time → 应用，光标+1，递归检查同一刻的下一个时间点
# 宏参数 tp_idx（读自 rhythm_axe:runtime.tp_idx）
# ★ 2026-09-13 补「同一刻多个时间点」的递归（与 event/advance、note/spawn 同构）：
#   旧版不递归 → 同刻第 2 个时间点永远不应用，且 #timing_cursor 永久卡死（time 已越过该刻），
#   此后所有时间点（tick rate / judgement_scale）全部失效。文档一直写的是“同一刻可能有多个”。
#arg: tp_idx
$execute if data storage rhythm_axe:runtime timing_points[$(tp_idx)].time run execute store result score #tp_time play_state run data get storage rhythm_axe:runtime timing_points[$(tp_idx)].time
$execute if data storage rhythm_axe:runtime timing_points[$(tp_idx)].time if score #tp_time play_state = time play_state run function rhythm_axe:play/timing/apply with storage rhythm_axe:runtime
$execute if data storage rhythm_axe:runtime timing_points[$(tp_idx)].time if score #tp_time play_state = time play_state run scoreboard players add #timing_cursor play_state 1
# 递归检查同一刻的下一个时间点（宏参数用更新后的 tp_idx；新元素时刻不同则自然停止）
execute store result storage rhythm_axe:runtime tp_idx int 1 run scoreboard players get #timing_cursor play_state
$execute if data storage rhythm_axe:runtime timing_points[$(tp_idx)].time if score #tp_time play_state = time play_state run function rhythm_axe:play/timing/advance with storage rhythm_axe:runtime
