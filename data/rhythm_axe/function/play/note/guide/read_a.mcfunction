# 读取引导线 A 端（前一个音符）展示实体的视觉中心 → #ax/#ay/#az（×100）
# @s = A 端音符展示实体（由 guide/tick 按 note_id = #ga 匹配）
scoreboard players operation #ax play_state = @s note_prev_x
scoreboard players operation #ay play_state = @s note_prev_y
scoreboard players operation #az play_state = @s note_prev_z
