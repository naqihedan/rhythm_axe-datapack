# 编辑器 hit_events 单条执行（递归；宏参数 fb_nid, case_name, idx）
# storage = rhythm_axe:editor.runtime + 假玩家 #ed_he_cursor/#ed_he_enabled（编辑器专属，与游玩系统隔离）
# cur_cmd 已由调用方（run_hit_events 首次 / hit_event_next 递归前）预先设置
# enabled 判断：data get 布尔值 → score（键存在且=1b 才执行）
# ★ 递归推进必须在独立函数 hit_event_next 完成（宏展开快照问题，与游玩系统同解）
#arg: fb_nid, case_name, idx
# 判断该条该情况是否启用（键不存在默认 0）
scoreboard players set #ed_he_enabled play_state 0
$execute if data storage rhythm_axe:editor.runtime hit_events.$(fb_nid)[$(idx)].enabled.$(case_name) run execute store result score #ed_he_enabled play_state run data get storage rhythm_axe:editor.runtime hit_events.$(fb_nid)[$(idx)].enabled.$(case_name) 1
# 启用 → 执行命令
execute if score #ed_he_enabled play_state matches 1 run function rhythm_axe:editor/visual/play_command with storage rhythm_axe:editor.runtime
# 游标+1（有下一条才推进）
$execute if data storage rhythm_axe:editor.runtime hit_events.$(fb_nid)[$(idx)].command run scoreboard players add #ed_he_cursor play_state 1
execute store result storage rhythm_axe:editor.runtime idx int 1 run scoreboard players get #ed_he_cursor play_state
# 有下一条 → 交给 hit_event_next（重新快照 idx=新值）预置 cur_cmd 后继续递归
$execute if data storage rhythm_axe:editor.runtime hit_events.$(fb_nid)[$(idx)].command run function rhythm_axe:editor/visual/hit_event_next with storage rhythm_axe:editor.runtime
