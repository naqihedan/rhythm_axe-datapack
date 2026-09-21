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
# ============ 引导线实体（note_guide_*；原先漏清，实体 kill 后计分项不会自动消失） ============
scoreboard players reset * note_guide_a
scoreboard players reset * note_guide_b
scoreboard players reset * note_guide_x
scoreboard players reset * note_guide_y
scoreboard players reset * note_guide_z
scoreboard players reset * note_guide_sx
scoreboard players reset * note_guide_sy
scoreboard players reset * note_guide_sz
scoreboard players reset * note_guide_tp
scoreboard players reset * note_guide_n
scoreboard players reset * note_guide_px
scoreboard players reset * note_guide_py
scoreboard players reset * note_guide_pz
# ============ 交互/点击 ============
scoreboard players reset * interacted
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
# ============ 编辑器音符视觉（editor_n_*，挂编辑器音符实体 UUID） ============
# ★ 2026-09-20 新增：这些项此前【没有任何地方清】。残留累计到 1 333 190 项 → scoreboard.dat 6.75MB
#   （解压 104MB），世界保存要序列化整份分数板 → 每几分钟一次 MSPT 尖峰（不玩谱面也卡）。
#   各类 kill 点已改为「kill 前先清」（见 editor/visual/note_scores_reset_）；这里负责一次性清掉历史残留。
# ★ 必须在【无编辑器音符活动】时调用（reload / 游戏结束）。load 里调用后若编辑器仍 active 会立刻 refresh 重建。
# ★ 新增 editor_n_* objective 时，此处与 editor/visual/note_scores_reset_.mcfunction 必须同步。
scoreboard players reset * editor_n_birth
scoreboard players reset * editor_n_time
scoreboard players reset * editor_n_end
scoreboard players reset * editor_n_dist
scoreboard players reset * editor_n_type
scoreboard players reset * editor_n_dur
scoreboard players reset * editor_n_density
scoreboard players reset * editor_n_lt
scoreboard players reset * editor_n_easing
scoreboard players reset * editor_n_power
scoreboard players reset * editor_n_len
scoreboard players reset * editor_n_seg
scoreboard players reset * editor_n_seg_count
scoreboard players reset * editor_n_size
scoreboard players reset * editor_n_protect
scoreboard players reset * editor_n_rec_life
scoreboard players reset * editor_n_hit
scoreboard players reset * editor_n_c_last
scoreboard players reset * editor_n_idx
scoreboard players reset * editor_n_px
scoreboard players reset * editor_n_py
scoreboard players reset * editor_n_pz
scoreboard players reset * editor_n_vx
scoreboard players reset * editor_n_vy
scoreboard players reset * editor_n_vz
scoreboard players reset * editor_n_sx
scoreboard players reset * editor_n_sy
scoreboard players reset * editor_n_sz
scoreboard players reset * editor_n_vvx
scoreboard players reset * editor_n_vvy
scoreboard players reset * editor_n_vvz
