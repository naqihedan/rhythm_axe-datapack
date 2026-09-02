# 事件命令递归推进器（宏参数 ev_idx, cmd_idx, cur_cmd）
# 在 execute 游标+1 后调用：此时 storage 的 cmd_idx 已更新，本函数快照 $(cmd_idx)=新值
# 用新 idx 预置下一条 cur_cmd，再递归回 execute
# ★ 背景（2026-08-07 与 hit_events 同一错位根因）：宏函数整体展开——execute 内游标+1 后，
#   若在本函数内 data modify cur_cmd 读 commands[$(cmd_idx)]，$(cmd_idx) 仍是调用时刻旧值
#   → 递归执行的 cur_cmd 恒指向前一条命令。必须拆到本函数用“新快照 idx”预置再递归。
#arg: ev_idx, cmd_idx, cur_cmd
# 预置下一条 cur_cmd（本次快照 cmd_idx 已是游标+1 后的新值）
$execute if data storage rhythm_axe:runtime events[$(ev_idx)].commands[$(cmd_idx)] run data modify storage rhythm_axe:runtime cur_cmd set from storage rhythm_axe:runtime events[$(ev_idx)].commands[$(cmd_idx)]
$execute if data storage rhythm_axe:runtime events[$(ev_idx)].commands[$(cmd_idx)] run function rhythm_axe:play/event/execute with storage rhythm_axe:runtime
