# ========== 动画完成 ==========
# ===== 1. 位置补偿 (s=2) =====
# apply_position=1 的预提交已在 start.mcfunction 的 pre_commit 中完成，无需再次处理
execute if score @s anim_apply_position matches 2 run function rhythm_axe:utilization/display_animation/apply_position_offset

# ===== 2. 清理实体动画状态计分板 =====
scoreboard players reset @s anim_status
scoreboard players reset @s anim_timer
scoreboard players reset @s anim_duration
scoreboard players reset @s anim_power
scoreboard players reset @s anim_apply_position

# 清理起始平移
scoreboard players reset @s anim_start_px
scoreboard players reset @s anim_start_py
scoreboard players reset @s anim_start_pz

# 清理起始旋转
scoreboard players reset @s anim_start_rx
scoreboard players reset @s anim_start_ry
scoreboard players reset @s anim_start_rz

# 清理起始缩放
scoreboard players reset @s anim_start_sx
scoreboard players reset @s anim_start_sy
scoreboard players reset @s anim_start_sz

# 清理终止平移
scoreboard players reset @s anim_end_px
scoreboard players reset @s anim_end_py
scoreboard players reset @s anim_end_pz

# 清理终止旋转
scoreboard players reset @s anim_end_rx
scoreboard players reset @s anim_end_ry
scoreboard players reset @s anim_end_rz

# 清理终止缩放
scoreboard players reset @s anim_end_sx
scoreboard players reset @s anim_end_sy
scoreboard players reset @s anim_end_sz

# 清理各分量"是否有变化"标志（2026-08-09；防残留导致下次动画 step 误判无变化/有变化）
scoreboard players reset @s anim_c_px
scoreboard players reset @s anim_c_py
scoreboard players reset @s anim_c_pz
scoreboard players reset @s anim_c_rx
scoreboard players reset @s anim_c_ry
scoreboard players reset @s anim_c_rz
scoreboard players reset @s anim_c_sx
scoreboard players reset @s anim_c_sy
scoreboard players reset @s anim_c_sz
scoreboard players reset @s anim_c_rot