# move 玻璃 marker 子函数：@s = 玻璃中心 marker（tag note_glass_center）
# 写 Pos = 玻璃中心（上上一刻中心 #pvx2/#pvy2/#pvz2 = 扫掠段起点）+ 记录上一刻中心（#pvx/#pvy_c/#pvz = 扫掠段终点）
# ★ 扫掠段整体退 1 刻（2026-08-08 用户实测玻璃判定早1刻）：起点=上上一刻、终点=上一刻 → 扫掠段=[P(T-2),P(T-1)] 对齐视觉路径
# 由 move 调用；执行后 move 外层 @s 恢复为展示实体
execute store result entity @s Pos[0] double 0.01 run scoreboard players get #pvx2 play_state
execute store result entity @s Pos[1] double 0.01 run scoreboard players get #pvy2 play_state
execute store result entity @s Pos[2] double 0.01 run scoreboard players get #pvz2 play_state
scoreboard players operation @s note_prev_x = #pvx play_state
scoreboard players operation @s note_prev_y = #pvy_c play_state
scoreboard players operation @s note_prev_z = #pvz play_state
