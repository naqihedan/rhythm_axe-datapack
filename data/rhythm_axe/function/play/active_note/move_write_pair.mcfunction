# move 配对子函数：@s = 与展示实体相同 note_id 的交互实体
# 写其 Pos = 上一刻视觉位置（#pvx/#pvy/#pvz 由 move 预置，×100 整数 → double 0.01）
# 由 move 调用（execute as @e ... run function）；执行后 move 外层 @s 恢复为展示实体（run function 不改变外层执行者）
# 优化：原 move 内联 3 条遍历 → 抽成 1 次遍历 + 函数内一次写完 Pos×3
# ★ 2026-09-26 判定延迟补偿：先把本次写入的位置推进「位置历史环」（非线性音符判定箱按玩家 RTT 回退用）。
#   只对走视线判定的音符盒/木板维护；在本函数【写 Pos 之前】调用（环的槽 0 = 即将写入的位置）。
execute if entity @s[tag=note_noteblock] run function rhythm_axe:play/active_note/vis_ring_next
execute if entity @s[tag=note_plank] run function rhythm_axe:play/active_note/vis_ring_next
execute store result entity @s Pos[0] double 0.01 run scoreboard players get #pvx play_state
execute store result entity @s Pos[1] double 0.01 run scoreboard players get #pvy play_state
execute store result entity @s Pos[2] double 0.01 run scoreboard players get #pvz play_state
