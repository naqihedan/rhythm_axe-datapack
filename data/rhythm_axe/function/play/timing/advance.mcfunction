# timing_point 推进：若 #timing_cursor 指向的时间点 time == time → 应用，光标+1
# 宏参数 tp_idx（读自 rhythm_axe:runtime.tp_idx）
#arg: tp_idx
$execute if data storage rhythm_axe:runtime timing_points[$(tp_idx)].time run execute store result score #tp_time play_state run data get storage rhythm_axe:runtime timing_points[$(tp_idx)].time
$execute if data storage rhythm_axe:runtime timing_points[$(tp_idx)].time if score #tp_time play_state = time play_state run function rhythm_axe:play/timing/apply with storage rhythm_axe:runtime
$execute if data storage rhythm_axe:runtime timing_points[$(tp_idx)].time if score #tp_time play_state = time play_state run scoreboard players add #timing_cursor play_state 1
