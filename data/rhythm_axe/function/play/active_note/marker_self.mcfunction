# marker 自算扫掠段端点（@s = 玻璃中心 marker，tag=note_glass_center）
# ★ 性能优化（2026-09-04，O(N²) 消除）：原 move 对每个玻璃展示实体全量扫描所有 marker
#   （N 展示 × N 标记 = O(N²)，52 玻璃 ≈ 2704 次选择器求值）写中心；改为 marker 在单遍遍历里
#   自算并滚动自己的中心，替代 move_write_marker。所需运动数据在 summon 时复制（motion/init → init_marker）。
# 每 tick（note_lin_t = L，与 display 同步递增）：
#   1. Pos = 旧 note_prev_*（= 上上一刻中心 P(T-2)，扫掠段起点）—— 先读后写，保住旧值
#   2. note_prev_* = 当前算出的"上一刻中心" P(T-1)（扫掠段终点）
#   位移 z(t) = -dist + (dist+end)×t/D；中心 = note_base_* + note_c_* 经 tz 缩放（y 用中心，不加减 half_size）
# 【安全前提】marker note_lin_t 与 display 同步递增（active_note 对 note_glass_center +1）→
#   note_lin_t-1 = 上一刻；Pos 的旧 note_prev_* = 上上一刻（由上一 tick 滚动而来）。
# 顺序必须保证：先写 Pos（读旧 note_prev_*）再更新 note_prev_*，否则旧值丢失。

# 1. Pos = 旧 note_prev_*（上上一刻中心 = 扫掠段起点）
execute store result entity @s Pos[0] double 0.01 run scoreboard players get @s note_prev_x
execute store result entity @s Pos[1] double 0.01 run scoreboard players get @s note_prev_y
execute store result entity @s Pos[2] double 0.01 run scoreboard players get @s note_prev_z

# 2. 算上一刻中心 P(T-1)：t = note_lin_t - 1（钳 [0, note_lin_dur]）
scoreboard players operation #mk_t play_state = @s note_lin_t
scoreboard players operation #mk_t play_state -= 1 const
execute if score #mk_t play_state < 0 const run scoreboard players set #mk_t play_state 0
execute if score #mk_t play_state > @s note_lin_dur run scoreboard players operation #mk_t play_state = @s note_lin_dur
# m_s = (dist + end) × t / D
scoreboard players operation #mk_s play_state = @s note_c_dist
scoreboard players operation #mk_s play_state += @s note_lin_end
scoreboard players operation #mk_s play_state *= #mk_t play_state
scoreboard players operation #mk_s play_state /= @s note_lin_dur
# tz = m_s - dist
scoreboard players operation #mk_tz play_state = #mk_s play_state
scoreboard players operation #mk_tz play_state -= @s note_c_dist
# x：wx = -sx×tz/dist；vx = base_x + wx
scoreboard players operation #mk_w play_state = @s note_c_sx
scoreboard players operation #mk_w play_state *= -1 const
scoreboard players operation #mk_w play_state *= #mk_tz play_state
scoreboard players operation #mk_w play_state /= @s note_c_dist
scoreboard players operation #mk_px play_state = @s note_base_x
scoreboard players operation #mk_px play_state += #mk_w play_state
# y：wy = -sy×tz/dist；vy = base_y + wy（中心，不减 half_size）
scoreboard players operation #mk_w play_state = @s note_c_sy
scoreboard players operation #mk_w play_state *= -1 const
scoreboard players operation #mk_w play_state *= #mk_tz play_state
scoreboard players operation #mk_w play_state /= @s note_c_dist
scoreboard players operation #mk_py play_state = @s note_base_y
scoreboard players operation #mk_py play_state += #mk_w play_state
# z：wz = -sz×tz/dist；vz = base_z + wz
scoreboard players operation #mk_w play_state = @s note_c_sz
scoreboard players operation #mk_w play_state *= -1 const
scoreboard players operation #mk_w play_state *= #mk_tz play_state
scoreboard players operation #mk_w play_state /= @s note_c_dist
scoreboard players operation #mk_pz play_state = @s note_base_z
scoreboard players operation #mk_pz play_state += #mk_w play_state
# 写上一刻中心 → note_prev_*（供下一 tick 作 Pos 起点 / 本 tick glass_sweep 终点）
scoreboard players operation @s note_prev_x = #mk_px play_state
scoreboard players operation @s note_prev_y = #mk_py play_state
scoreboard players operation @s note_prev_z = #mk_pz play_state
