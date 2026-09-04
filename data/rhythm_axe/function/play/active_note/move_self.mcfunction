# 交互实体自算"上一刻"视觉位置并写自身 Pos（@s = note_interaction，tag=note_linear）
# ★ 性能优化（2026-09-04，O(N²) 消除）：原 move 对每个展示实体都 @e[type=interaction] 全量扫描找配对
#   （N 展示 × N 交互 = O(N²)）；改为交互实体在单遍遍历里自算位置，所需数据已在 summon 时 motion/init
#   复制到交互实体（见 play/note/motion/init + init_interaction）。
#   公式与 move 完全一致（读 note_lin_t 就近用 -1 解耦 1 刻延迟），仅执行者从展示实体换成交互实体。
#   位置 = 判定位置(note_base_*) + 起始偏移(note_c_sx/sy/sz) 经 tz 缩放；y 减 half_size（交互实体为脚底）。
#   线性 z(t) = -dist + (dist+end)×t/D  →  tz = ((dist+end)×t/D) - dist
#   【安全前提】交互实体的 note_lin_t 与展示实体同步递增（active_note 同刻对 note_linear 实体 +1），
#   故 note_lin_t-1 = 展示实体上一刻的 t = move 写 #pvx 用的"上一刻位置"，解耦延迟一致。

# 进度 t = note_lin_t - 1（上一刻），钳制到 [0, note_lin_dur]
#   （正常流程下交互实体 note_lin_t 已同刻 +1，÷ 后至少为 1，t 不会 <0；此处下界钳制防边界异常）
scoreboard players operation #m_t display_calc = @s note_lin_t
scoreboard players operation #m_t display_calc -= 1 const
execute if score #m_t display_calc < 0 const run scoreboard players set #m_t display_calc 0
execute if score #m_t display_calc > @s note_lin_dur run scoreboard players operation #m_t display_calc = @s note_lin_dur
# m_s = (dist + end) × t / D
scoreboard players operation #m_s display_calc = @s note_c_dist
scoreboard players operation #m_s display_calc += @s note_lin_end
scoreboard players operation #m_s display_calc *= #m_t display_calc
scoreboard players operation #m_s display_calc /= @s note_lin_dur
# tz = m_s - dist
scoreboard players operation #tz play_state = #m_s display_calc
scoreboard players operation #tz play_state -= @s note_c_dist
# x：wx = -sx×tz/dist；vx = base_x + wx
scoreboard players operation #wx display_calc = @s note_c_sx
scoreboard players operation #wx display_calc *= -1 const
scoreboard players operation #wx display_calc *= #tz play_state
scoreboard players operation #wx display_calc /= @s note_c_dist
scoreboard players operation #vx play_state = @s note_base_x
scoreboard players operation #vx play_state += #wx display_calc
# y：wy = -sy×tz/dist；vy = base_y + wy - half_size
scoreboard players operation #wy display_calc = @s note_c_sy
scoreboard players operation #wy display_calc *= -1 const
scoreboard players operation #wy display_calc *= #tz play_state
scoreboard players operation #wy display_calc /= @s note_c_dist
scoreboard players operation #vy play_state = @s note_base_y
scoreboard players operation #vy play_state += #wy display_calc
scoreboard players operation #vy play_state -= @s note_half_size
# z：wz = -sz×tz/dist；vz = base_z + wz
scoreboard players operation #wz display_calc = @s note_c_sz
scoreboard players operation #wz display_calc *= -1 const
scoreboard players operation #wz display_calc *= #tz play_state
scoreboard players operation #wz display_calc /= @s note_c_dist
scoreboard players operation #vz play_state = @s note_base_z
scoreboard players operation #vz play_state += #wz display_calc
# 写交互实体自身 Pos（x/z 中心、y 脚底）
execute store result entity @s Pos[0] double 0.01 run scoreboard players get #vx play_state
execute store result entity @s Pos[1] double 0.01 run scoreboard players get #vy play_state
execute store result entity @s Pos[2] double 0.01 run scoreboard players get #vz play_state
