# 事件指令递归推进器（宏参数：cursor, ev_idx, cmd_idx, cur_cmd）
# 在 event_execute_ 游标+1 后调用：此时 prop.cmd_idx 已更新，本函数快照 $(cmd_idx)=新值
# 用新 idx 预置下一条 cur_cmd，再递归回 event_execute_
# ★ 背景（与 play/event/execute_next 同解）：宏函数整体展开——若在 event_execute_ 内游标+1 后
#   直接 data modify 读 commands[$(cmd_idx)]，拿到的仍是调用时刻旧条
#   → 曾表现为「多条指令时：首条执行两次、最后一条从不执行」。
#arg: cursor, ev_idx, cmd_idx, cur_cmd
# 预置下一条 cur_cmd（本次快照 cmd_idx 已是游标+1 后的新值）
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].events[$(ev_idx)].commands[$(cmd_idx)] run data modify storage rhythm_axe:prop cur_cmd set from storage rhythm_axe:maps.editor history[$(cursor)].events[$(ev_idx)].commands[$(cmd_idx)]
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].events[$(ev_idx)].commands[$(cmd_idx)] run function rhythm_axe:editor/visual/event_execute_ with storage rhythm_axe:prop
