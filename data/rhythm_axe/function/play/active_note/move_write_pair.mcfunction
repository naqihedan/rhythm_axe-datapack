# move 配对子函数：@s = 与展示实体相同 note_id 的交互实体
# 写其 Pos = 上一刻视觉位置（#pvx/#pvy/#pvz 由 move 预置，×100 整数 → double 0.01）
# 由 move 调用（execute as @e ... run function）；执行后 move 外层 @s 恢复为展示实体（run function 不改变外层执行者）
# 优化：原 move 内联 3 条遍历 → 抽成 1 次遍历 + 函数内一次写完 Pos×3
execute store result entity @s Pos[0] double 0.01 run scoreboard players get #pvx play_state
execute store result entity @s Pos[1] double 0.01 run scoreboard players get #pvy play_state
execute store result entity @s Pos[2] double 0.01 run scoreboard players get #pvz play_state
