# 事件推进：若 #event_cursor 指向的事件 time == time → 执行其 commands，光标+1，递归检查同一刻的下一个事件
# 宏参数 ev_idx（读自 rhythm_axe:runtime.ev_idx；main_loop 每刻调用，仿 timing/advance + note/spawn 的游标模式）
#arg: ev_idx
# 读取当前事件执行时间
$execute if data storage rhythm_axe:runtime events[$(ev_idx)].time run execute store result score #ev_time play_state run data get storage rhythm_axe:runtime events[$(ev_idx)].time
# 到时间：初始化命令游标=0，把第一条命令复制到 cur_cmd，再调 execute
# ★ 宏 $(cur_cmd) 用的是“调用 execute 那一刻”runtime.cur_cmd 的值（宏函数整体展开）——
#   cur_cmd 必须在调 execute 之前设置好，不能依赖 execute 内部“先设再用”
$execute if data storage rhythm_axe:runtime events[$(ev_idx)].time if score #ev_time play_state = time play_state run scoreboard players set #ev_cmd_idx play_state 0
$execute if data storage rhythm_axe:runtime events[$(ev_idx)].time if score #ev_time play_state = time play_state run execute store result storage rhythm_axe:runtime cmd_idx int 1 run scoreboard players get #ev_cmd_idx play_state
$execute if data storage rhythm_axe:runtime events[$(ev_idx)].time if score #ev_time play_state = time play_state run data modify storage rhythm_axe:runtime cur_cmd set from storage rhythm_axe:runtime events[$(ev_idx)].commands[0]
$execute if data storage rhythm_axe:runtime events[$(ev_idx)].time if score #ev_time play_state = time play_state run function rhythm_axe:play/event/execute with storage rhythm_axe:runtime
# 事件游标+1，并递归检查同一刻的下一个事件（宏参数用更新后的 ev_idx）
$execute if data storage rhythm_axe:runtime events[$(ev_idx)].time if score #ev_time play_state = time play_state run scoreboard players add #event_cursor play_state 1
execute store result storage rhythm_axe:runtime ev_idx int 1 run scoreboard players get #event_cursor play_state
$execute if data storage rhythm_axe:runtime events[$(ev_idx)].time if score #ev_time play_state = time play_state if data storage rhythm_axe:runtime events[$(ev_idx)].time run function rhythm_axe:play/event/advance with storage rhythm_axe:runtime
