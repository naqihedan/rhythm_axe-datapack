# move 配对子函数：@s = 与展示实体相同 note_id 的交互实体
# 写其 Pos = 上一刻视觉位置（#pvx/#pvy/#pvz 由 move 预置，×100 整数 → double 0.01）
# 由 move 调用（execute as @e ... run function）；执行后 move 外层 @s 恢复为展示实体（run function 不改变外层执行者）
# 优化：原 move 内联 3 条遍历 → 抽成 1 次遍历 + 函数内一次写完 Pos×3
# ★ 2026-09-26 判定延迟补偿：先把本次写入的位置推进「位置历史环」（非线性音符判定箱按玩家 RTT 回退用）。
#   只对走视线判定的音符盒/木板维护；在本函数【写 Pos 之前】调用（环的槽 0 = 即将写入的位置）。
# ⏸ 2026-09-29 性能修复：补偿已搁置 ⇒ 用总开关门控本调用（原来是无条件调用）。
#   为什么要门控：vis_ring_next = 28 条命令，且是「每刻 × 每个非线性音符盒/木板」的恒定开销；
#   judge_lag_comp 默认 0 ⇒ 现在只花 2 次计分板判断，非线性音符的每刻开销回到补偿前水平。
#   ⚠ 要重新启用：先设 judge_lag_comp=1 再进谱面（中途打开会让在飞的音符读到过期环位置）。
execute if score judge_lag_comp options matches 1 if entity @s[tag=note_noteblock] run function rhythm_axe:play/active_note/vis_ring_next
execute if score judge_lag_comp options matches 1 if entity @s[tag=note_plank] run function rhythm_axe:play/active_note/vis_ring_next
execute store result entity @s Pos[0] double 0.01 run scoreboard players get #pvx play_state
execute store result entity @s Pos[1] double 0.01 run scoreboard players get #pvy play_state
execute store result entity @s Pos[2] double 0.01 run scoreboard players get #pvz play_state
