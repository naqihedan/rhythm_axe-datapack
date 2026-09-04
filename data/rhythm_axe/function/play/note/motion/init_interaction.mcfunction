# 交互实体：复制展示实体快照的运动数据给它（供 move_self 自算位置，O(N²) 消除）
# @s = note_interaction；#d_* 由 motion/init 从展示实体捕获（summon 逐音符处理，无并发串扰）
# ★ 性能优化（2026-09-04）：这些目标计分板原本只在展示实体上维护，此处同步到交互实体，
#   使交互实体无需在每 tick 反查展示实体即可算出自己应处的视觉位置。
scoreboard players operation @s note_base_x = #d_bx play_state
scoreboard players operation @s note_base_y = #d_by play_state
scoreboard players operation @s note_base_z = #d_bz play_state
scoreboard players operation @s note_c_sx = #d_sx play_state
scoreboard players operation @s note_c_sy = #d_sy play_state
scoreboard players operation @s note_c_sz = #d_sz play_state
scoreboard players operation @s note_c_dist = #d_cd play_state
scoreboard players operation @s note_half_size = #d_hs play_state
scoreboard players operation @s note_lin_dur = #d_dur play_state
scoreboard players operation @s note_lin_end = #d_end play_state
scoreboard players set @s note_lin_t 0
