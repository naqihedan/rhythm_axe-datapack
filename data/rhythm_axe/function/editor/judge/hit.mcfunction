# 编辑器真实判定：命中收尾（@s = 编辑器音符展示实体；#ed_life = 判定用寿命）
# 流程：算等级 → 播音符事件（情况 = 等级）→ 文字反馈 → 清除音符对
# ★ 木板（type 1）照搬游玩 main_plank 语义：无 bad/miss，命中一律按大 P（把寿命视为 0 再查档）
# ★ #ed_level 由 visual/trigger 消费（它负责音效/粒子查表 + hit_events 情况键）并当场清空，
#   故文字反馈另用 #ed_disp 传等级（否则 trigger 清空后 feedback_text 会读到空值 → 误显示 BAD）
execute if score @s editor_n_type matches 1 run scoreboard players set #ed_life editor 0
function rhythm_axe:editor/judge/level
scoreboard players operation #ed_disp editor = #ed_level editor
function rhythm_axe:editor/visual/trigger
function rhythm_axe:editor/judge/feedback_text
function rhythm_axe:editor/visual/tick_kill
