# 编辑器 hit_events 按情况执行（@s = 编辑器音符展示实体）
#arg: te_cursor, te_idx, fb_nid, te_case
# ★ 与游玩 play/feedback/feedback 对齐：复制该音符 hit_events → 按 case_name 过滤 enabled → 宏执行指令
# ★ 调用方：editor/visual/tick_one.mcfunction 末尾（仅 editor_play_events=1）
#   ★ 执行者/位置 = 配对交互实体（@s，随音符移动，调用方 `as … at @s`）—— 与游玩 play/feedback/tick_event 一致；
#     指令里的 `~ ~ ~` / `@s` 都落在音符**当前位置**，不是固定的判定位置
#   · te_case="spawn"：音符「开始移动那一刻」执行一次（实体首次被 tick_one 处理的刻）
#   · te_case="tick" ：此后每一刻执行（直到音符被判定/清除）
#   ⚠ 判定情况（bad/good_early/.../miss）走 trigger_，玻璃 damage 走 glass_feedback —— 三者互不干扰
# ★ 无 hit_events 数据的音符在首行立即 return（不写 runtime、不跑执行链）
$execute unless data storage rhythm_axe:maps.editor history[$(te_cursor)].notes[$(te_idx)].hit_events run return 0
$data modify storage rhythm_axe:editor.runtime hit_events.$(fb_nid) set from storage rhythm_axe:maps.editor history[$(te_cursor)].notes[$(te_idx)].hit_events
$data modify storage rhythm_axe:editor.runtime case_name set value "$(te_case)"
function rhythm_axe:editor/visual/run_hit_events with storage rhythm_axe:editor.runtime
$execute if data storage rhythm_axe:editor.runtime hit_events.$(fb_nid) run data remove storage rhythm_axe:editor.runtime hit_events.$(fb_nid)
execute if data storage rhythm_axe:editor.runtime case_name run data remove storage rhythm_axe:editor.runtime case_name
execute if data storage rhythm_axe:editor.runtime fb_nid run data remove storage rhythm_axe:editor.runtime fb_nid
