# 编辑器真实判定：未命中收尾（@s = 编辑器音符展示实体；已确认 life < -2x）
# 木板（type 1）：照搬游玩 judgement/clear_note —— 静默清除（无 miss 音效、无 miss 文字）
# 其余（音符盒 0 / 唱片机 2）：miss（情况键 miss；默认组 miss 音效/粒子为空 ⇒ 实际只有文字反馈，与游玩一致）
# ★ 两者都要清除音符对（kill 展示 + 配对交互 + 清计分项）
execute if score @s editor_n_type matches 1 run function rhythm_axe:editor/visual/tick_kill
execute if score @s editor_n_type matches 1 run return 0
scoreboard players set #ed_level editor 6
scoreboard players set #ed_disp editor 6
function rhythm_axe:editor/visual/trigger
function rhythm_axe:editor/judge/feedback_text
function rhythm_axe:editor/visual/tick_kill
