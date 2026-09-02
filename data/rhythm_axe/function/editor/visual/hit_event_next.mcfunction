# 编辑器 hit_events 递归推进器（宏参数 fb_nid, case_name, idx）
# storage = rhythm_axe:editor.runtime（编辑器专属，与游玩系统隔离）
# 在 hit_event 游标+1 后调用：此时 storage 的 idx 已更新，本函数快照 $(idx)=新值
# 用新 idx 预置下一条 cur_cmd，再递归回 hit_event（宏展开快照问题，与游玩系统同解）
#arg: fb_nid, case_name, idx
# 预置下一条 cur_cmd（本次快照 idx 已是游标+1 后的新值）
$execute if data storage rhythm_axe:editor.runtime hit_events.$(fb_nid)[$(idx)].command run data modify storage rhythm_axe:editor.runtime cur_cmd set from storage rhythm_axe:editor.runtime hit_events.$(fb_nid)[$(idx)].command
$execute if data storage rhythm_axe:editor.runtime hit_events.$(fb_nid)[$(idx)].command run function rhythm_axe:editor/visual/hit_event with storage rhythm_axe:editor.runtime
