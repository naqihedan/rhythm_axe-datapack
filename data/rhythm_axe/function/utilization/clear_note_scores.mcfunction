# 清空所有音符计分板的全部计分项（scoreboard players reset *）
# 用途：游戏结束（end_of_game）或重载（load）时调用，防 note_* 计分板残留堆积。
# 背景：note_* 计分板的分数项挂在【音符实体 UUID】上。实体被 kill/自然消失后，
#   计分项【不会】随实体移除而自动清除（Java 版计分板项按“名字”持久存在，实体移除不清分）。
#   且 end_of_game 里 `scoreboard players reset @e[tag=map_$(mapid)]` 只能清【仍存活】实体——
#   中途判定/出窗已消失的音符（实体已不在世界，@e 选不中）残留项清不掉。
# 用法：`scoreboard players reset * <objective>`——* 通配所有有该计分板分数的名字，
#   包括已死亡/已卸载音符的残留项（@e 选不中的都能清掉）。比 remove+add 更简洁且无副作用。
# ★ 必须在【无音符活动】时调用（游戏结束/重载）。
# ★ 新增 note_* 计分板时，load.mcfunction 与此处必须同步（否则残留项漏清）。

# ============ 基础配对/寿命/状态 ============
scoreboard players reset * note_id
scoreboard players reset * note_life
scoreboard players reset * note_protect
scoreboard players reset * note_recorded_life
scoreboard players reset * note_active
# ============ 视觉位置快照（×100） ============
scoreboard players reset * note_prev_x
scoreboard players reset * note_prev_y
scoreboard players reset * note_prev_z
scoreboard players reset * note_prev2_x
scoreboard players reset * note_prev2_y
scoreboard players reset * note_prev2_z
scoreboard players reset * note_base_x
scoreboard players reset * note_base_y
scoreboard players reset * note_base_z
scoreboard players reset * note_half_size
scoreboard players reset * note_cur_tz
# ============ 交互/点击 ============
scoreboard players reset * interacted
scoreboard players reset * note_last_right
scoreboard players reset * note_last_attack
# ============ 阶段C 线性客户端插值 ============
scoreboard players reset * note_lin_dur
scoreboard players reset * note_lin_t
scoreboard players reset * note_lin_end
# ============ 混凝土（移动参数 + 分段 + 交互复刻） ============
scoreboard players reset * note_c_sx
scoreboard players reset * note_c_sy
scoreboard players reset * note_c_sz
scoreboard players reset * note_c_lt
scoreboard players reset * note_c_m
scoreboard players reset * note_c_dist
scoreboard players reset * note_c_size
scoreboard players reset * note_c_seg
scoreboard players reset * note_c_density
scoreboard players reset * note_c_dur
scoreboard players reset * note_c_seg_done
scoreboard players reset * note_c_seg_end
scoreboard players reset * note_c_seg_idx
scoreboard players reset * note_c_seg_count
scoreboard players reset * note_c_done
scoreboard players reset * note_c_qx
scoreboard players reset * note_c_qy
scoreboard players reset * note_c_qz
scoreboard players reset * note_c_qw
scoreboard players reset * note_c_easing
scoreboard players reset * note_c_power
scoreboard players reset * note_c_seg2_s
scoreboard players reset * note_c_seg1_s
scoreboard players reset * note_c_seg1_dur
scoreboard players reset * note_prev_cx
scoreboard players reset * note_prev_cy
scoreboard players reset * note_prev_cz
# ============ 玻璃 ============
scoreboard players reset * note_g_seg
scoreboard players reset * note_glass_dur
# ============ 判定反馈 ============
scoreboard players reset * note_hitsound
scoreboard players reset * note_hit_particles
scoreboard players reset * note_color
