# 玻璃中心 marker：复制展示实体运动数据给自身（供 marker_self 自算扫掠段，O(N²) 消除）
# @s = 玻璃中心 marker（tag=note_glass_center）；#d_* 由 motion/init 从展示实体捕获（summon 逐音符，无并发串扰）
# ★ 性能优化（2026-09-04）：这些目标计分板原本只在展示实体上维护，此处同步到 marker，
#   使 marker 无需在每 tick 反查展示实体即可自算扫掠段（起点=上上一刻、终点=上一刻）。
# 中心 y 不加减 half_size（marker 为方块中心；交互实体减 half_size 是因为它是脚底）。
scoreboard players operation @s note_base_x = #d_bx play_state
scoreboard players operation @s note_base_y = #d_by play_state
scoreboard players operation @s note_base_z = #d_bz play_state
scoreboard players operation @s note_c_sx = #d_sx play_state
scoreboard players operation @s note_c_sy = #d_sy play_state
scoreboard players operation @s note_c_sz = #d_sz play_state
scoreboard players operation @s note_c_dist = #d_cd play_state
scoreboard players operation @s note_lin_dur = #d_dur play_state
scoreboard players operation @s note_lin_end = #d_end play_state
scoreboard players set @s note_lin_t 0
# note_prev_*（上一刻中心）初始 = 初始视觉中心 = base + start（中心(0)；z(0)=-dist → wx(0)=sx → vx(0)=base+sx）
scoreboard players operation @s note_prev_x = @s note_base_x
scoreboard players operation @s note_prev_x += @s note_c_sx
scoreboard players operation @s note_prev_y = @s note_base_y
scoreboard players operation @s note_prev_y += @s note_c_sy
scoreboard players operation @s note_prev_z = @s note_base_z
scoreboard players operation @s note_prev_z += @s note_c_sz
