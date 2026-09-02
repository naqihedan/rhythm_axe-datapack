# hit_events 递归推进器（宏参数 fb_nid, case_name, idx）
# 在 hit_event 游标+1 后调用：此时 storage 的 idx 已更新，本函数快照 $(idx)=新值
# 用新 idx 预置下一条 cur_cmd，再递归回 hit_event
# ★ 背景（2026-08-07 击打事件错位根因）：宏函数整体展开——hit_event 内游标+1 后，
#   若在本函数内 data modify cur_cmd 读 hit_events[$(idx)]，$(idx) 仍是调用时刻旧值
#   → 递归执行的 cur_cmd 恒指向前一条指令（Miss→BAD、Bad→GOOD、Good→PERFECT 的错位）。
#   必须拆到本函数用“新快照 idx”完成下一条 cur_cmd 的预置，再递归回 hit_event。
#arg: fb_nid, case_name, idx
# 预置下一条 cur_cmd（本次快照 idx 已是游标+1 后的新值）
$execute if data storage rhythm_axe:runtime hit_events.$(fb_nid)[$(idx)].command run data modify storage rhythm_axe:runtime cur_cmd set from storage rhythm_axe:runtime hit_events.$(fb_nid)[$(idx)].command
$execute if data storage rhythm_axe:runtime hit_events.$(fb_nid)[$(idx)].command run function rhythm_axe:play/feedback/hit_event with storage rhythm_axe:runtime
