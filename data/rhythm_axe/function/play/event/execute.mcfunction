# 执行事件的一条命令（宏参数 ev_idx, cmd_idx, cur_cmd）
# cur_cmd 已由调用方（advance 首次 / execute_next 递归前）预先设置好；$(cur_cmd) 用调用时刻值
# ★ 不能在函数内部“先 data modify 设 cur_cmd 再 $(cur_cmd)”——宏整体展开，第二处读到的还是旧值（事件不触发的根因）
# ★ 递归预置下一条 cur_cmd 必须在独立函数 execute_next 完成（2026-08-07 同 hit_events 错位根因）：
#   本函数内 $(cmd_idx) 是调用时刻旧快照，游标+1 后直接 data modify 读 commands[$(cmd_idx)] 还是旧条
#   → 拆到 execute_next（新快照 idx）预置 cur_cmd 后再递归回本函数
#arg: ev_idx, cmd_idx, cur_cmd
# 宏展开执行（谱师输入的命令字符串；执行者保持调用者）
$execute if data storage rhythm_axe:runtime cur_cmd run execute positioned 0.0 0.0 0.0 run $(cur_cmd)
# 命令游标+1
$execute if data storage rhythm_axe:runtime events[$(ev_idx)].commands[$(cmd_idx)] run scoreboard players add #ev_cmd_idx play_state 1
execute store result storage rhythm_axe:runtime cmd_idx int 1 run scoreboard players get #ev_cmd_idx play_state
# 有下一条 → 交给 execute_next（重新快照 cmd_idx=新值）预置 cur_cmd 后继续递归
$execute if data storage rhythm_axe:runtime events[$(ev_idx)].commands[$(cmd_idx)] run function rhythm_axe:play/event/execute_next with storage rhythm_axe:runtime
