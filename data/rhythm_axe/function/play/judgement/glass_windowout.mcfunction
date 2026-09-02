# 染色玻璃出窗（@s = 玻璃交互实体）：寿命 + duration <= 0 → 静默清除
# ★ 出窗延迟 2 tick（2026-08-09）：玻璃视觉 D=lt+dur-1 到位 +end，与出窗 -dur 只差 1 tick；
#   26.x 客户端插值渲染有延迟 → 视觉未走完就被删（"只运动到一半就出窗"）。延迟 2 tick 留缓冲。
# 单实体上下文计算 #neg_gdur（as @e 循环里不能对共享变量 *= -1，见 concrete_windowout 教训）
scoreboard players operation #neg_gdur play_state = @s note_glass_dur
scoreboard players operation #neg_gdur play_state += 2 const
scoreboard players operation #neg_gdur play_state *= -1 const
# duration=0 时：寿命 0 那一刻存活，寿命 -1 消失（文档）→ 下界 -1 而非 0
execute if score @s note_glass_dur matches 0 run scoreboard players set #neg_gdur play_state -1
execute if score @s note_life <= #neg_gdur play_state run function rhythm_axe:play/judgement/clear_note
