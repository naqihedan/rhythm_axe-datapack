# hit_events 单条执行（递归；宏参数 fb_nid, case_name, idx）
# cur_cmd 已由调用方（run_hit_events 首次 / hit_event_next 递归前）预先设置
# enabled 判断：data get 布尔值 → score（键存在且=1b 才执行）
# ★ 递归推进必须在独立函数 hit_event_next 完成（2026-08-07 击打事件错位根因）：
#   宏函数整体展开——本函数内 $(idx) 是调用时刻快照，游标+1 后若在本函数里
#   data modify cur_cmd 读取 hit_events[$(idx)] 仍是旧 idx 的 command（不是下一条）
#   → 下一条必须由“新快照 idx”的 hit_event_next 预置后再递归回本函数
#arg: fb_nid, case_name, idx
# 判断该条该情况是否启用（键不存在默认 0）
scoreboard players set #he_enabled play_state 0
$execute if data storage rhythm_axe:runtime hit_events.$(fb_nid)[$(idx)].enabled.$(case_name) run execute store result score #he_enabled play_state run data get storage rhythm_axe:runtime hit_events.$(fb_nid)[$(idx)].enabled.$(case_name) 1
# 启用 → 执行命令
execute if score #he_enabled play_state matches 1 run function rhythm_axe:play/feedback/play_command with storage rhythm_axe:runtime
# 游标+1（有下一条才推进）
$execute if data storage rhythm_axe:runtime hit_events.$(fb_nid)[$(idx)].command run scoreboard players add #he_cursor play_state 1
execute store result storage rhythm_axe:runtime idx int 1 run scoreboard players get #he_cursor play_state
# 有下一条 → 交给 hit_event_next（重新快照 idx=新值）预置 cur_cmd 后继续递归
$execute if data storage rhythm_axe:runtime hit_events.$(fb_nid)[$(idx)].command run function rhythm_axe:play/feedback/hit_event_next with storage rhythm_axe:runtime
