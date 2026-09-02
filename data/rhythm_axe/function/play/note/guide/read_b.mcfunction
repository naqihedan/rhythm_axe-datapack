# 读取引导线 B 端（当前音符）展示实体的视觉中心 → #bx/#by/#bz（×100）
# @s = B 端音符展示实体（由 guide/tick 按 note_id = #gb 匹配）
scoreboard players operation #bx play_state = @s note_prev_x
scoreboard players operation #by play_state = @s note_prev_y
scoreboard players operation #bz play_state = @s note_prev_z
