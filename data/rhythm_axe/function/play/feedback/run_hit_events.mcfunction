# hit_events 执行入口（宏参数 fb_nid；预置游标 0、idx、第一条 cur_cmd 后递归）
# 存储位置：storage rhythm_axe:runtime hit_events.<note_id> = [ {command, enabled:{...}}, ... ]
#arg: fb_nid
$execute if data storage rhythm_axe:runtime hit_events.$(fb_nid)[0].command run scoreboard players set #he_cursor play_state 0
# ★ 递归前必须预置 idx（hit_event 展开 $(idx) 用调用时刻值；与事件系统 cmd_idx 同理）
$execute if data storage rhythm_axe:runtime hit_events.$(fb_nid)[0].command run execute store result storage rhythm_axe:runtime idx int 1 run scoreboard players get #he_cursor play_state
$execute if data storage rhythm_axe:runtime hit_events.$(fb_nid)[0].command run data modify storage rhythm_axe:runtime cur_cmd set from storage rhythm_axe:runtime hit_events.$(fb_nid)[0].command
$execute if data storage rhythm_axe:runtime hit_events.$(fb_nid)[0].command run function rhythm_axe:play/feedback/hit_event with storage rhythm_axe:runtime
