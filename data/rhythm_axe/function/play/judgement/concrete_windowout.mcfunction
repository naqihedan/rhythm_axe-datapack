# 混凝土出窗（@s = 混凝土交互实体）：寿命 ≤ -(dur+ext) → 静默清除
# ext = 末段过短（末段长 < 3x）时的延长量 3x（音符.md 长条过短保护）；否则 0
# ★ 2026-09-04 段③渲染缓冲：段③在判定后还需 m 刻收缩（尾端到判定、len→0），出窗清除延后 2 刻，
#   确保段③插值最终帧渲染完成再清除（否则"长条尾未到底就消失"）。
# ★ 必须在单实体上下文中计算共享变量（as @e 循环里 *= -1 会对全局重复取反，M2-F 大坑）
scoreboard players operation #x3 play_state = #judgement_scale play_state
scoreboard players operation #x3 play_state *= 3 const
scoreboard players operation #ll play_state = @s note_c_dur
scoreboard players operation #ll play_state %= @s note_c_density
execute if score #ll play_state matches 0 run scoreboard players operation #ll play_state = @s note_c_density
scoreboard players operation #neg_dur play_state = @s note_c_dur
execute if score #ll play_state < #x3 play_state run scoreboard players operation #neg_dur play_state += #x3 play_state
scoreboard players operation #neg_dur play_state *= -1 const
# ★ 2026-09-04：清除阈值延后 2 刻（段③渲染缓冲；判定 miss/perfect 在 main_concrete 已独立完成，出窗只负责清实体）
scoreboard players operation #neg_dur play_state -= 2 const
execute if score @s note_life <= #neg_dur play_state run function rhythm_axe:play/judgement/clear_note
