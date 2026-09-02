# 编辑器 hit_events 执行入口（宏参数 fb_nid；预置游标 0、idx、第一条 cur_cmd 后递归）
# storage = rhythm_axe:editor.runtime + 假玩家 #ed_he_cursor（编辑器专属，与游玩系统隔离）
# 存储位置：storage rhythm_axe:editor.runtime hit_events.<note_id> = [ {command, enabled:{...}}, ... ]
#arg: fb_nid
$execute if data storage rhythm_axe:editor.runtime hit_events.$(fb_nid)[0].command run scoreboard players set #ed_he_cursor play_state 0
# ★ 递归前必须预置 idx（hit_event 展开 $(idx) 用调用时刻值）
$execute if data storage rhythm_axe:editor.runtime hit_events.$(fb_nid)[0].command run execute store result storage rhythm_axe:editor.runtime idx int 1 run scoreboard players get #ed_he_cursor play_state
$execute if data storage rhythm_axe:editor.runtime hit_events.$(fb_nid)[0].command run data modify storage rhythm_axe:editor.runtime cur_cmd set from storage rhythm_axe:editor.runtime hit_events.$(fb_nid)[0].command
$execute if data storage rhythm_axe:editor.runtime hit_events.$(fb_nid)[0].command run function rhythm_axe:editor/visual/hit_event with storage rhythm_axe:editor.runtime
