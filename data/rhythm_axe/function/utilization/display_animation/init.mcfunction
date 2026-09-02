# ========== display_animation 初始化 ==========
# 在数据包 load 时调用，初始化计分板和累计器。
# 确保 display_calc 计分板存在（若已存在则此命令失败，但无害）
scoreboard objectives add display_calc dummy

# 初始化三角函数查表（★ 2026-08-14 恢复：引导线朝向用 euler_to_quat 查此表；此前仅音符恒单位四元数不需要，
#   注释掉导致引导线位置角度全错。表函数开头 set value [] 清空重建，reload 安全；load 时一次性建表，不影响 tick）
# 如果有什么操作误修改了表格，需要执行这个函数重置表格
function rhythm_axe:utilization/math/init_trig_table

# 创建动画状态相关计分板
scoreboard objectives add anim_status dummy
scoreboard objectives add anim_timer dummy
scoreboard objectives add anim_duration dummy
scoreboard objectives add anim_power dummy
scoreboard objectives add anim_apply_position dummy

# 创建动画起始平移分量计分板
scoreboard objectives add anim_start_px dummy
scoreboard objectives add anim_start_py dummy
scoreboard objectives add anim_start_pz dummy

# 创建动画起始旋转分量计分板
scoreboard objectives add anim_start_rx dummy
scoreboard objectives add anim_start_ry dummy
scoreboard objectives add anim_start_rz dummy

# 创建动画起始缩放分量计分板
scoreboard objectives add anim_start_sx dummy
scoreboard objectives add anim_start_sy dummy
scoreboard objectives add anim_start_sz dummy

# 创建动画终止平移分量计分板
scoreboard objectives add anim_end_px dummy
scoreboard objectives add anim_end_py dummy
scoreboard objectives add anim_end_pz dummy

# 创建动画终止旋转分量计分板
scoreboard objectives add anim_end_rx dummy
scoreboard objectives add anim_end_ry dummy
scoreboard objectives add anim_end_rz dummy

# 创建动画终止缩放分量计分板
scoreboard objectives add anim_end_sx dummy
scoreboard objectives add anim_end_sy dummy
scoreboard objectives add anim_end_sz dummy

# 创建缓动类型计分板（1=缓入 2=缓出 3=缓入缓出）
scoreboard objectives add anim_easing dummy

# 创建实体当前欧拉角记录计分板（用于下次动画读取起始朝向）
scoreboard objectives add anim_cur_rx dummy
scoreboard objectives add anim_cur_ry dummy
scoreboard objectives add anim_cur_rz dummy

# 各分量"是否有变化"标志（0=无变化 1=有变化；step 据此跳过无变化分量的插值，2026-08-09）
# ★ 优化背景：音符动画旋转恒为单位四元数、多数分量 end==start，但 step 原版每 tick 对 9 个分量无条件插值 + 旋转计算
#   → 每实体每 tick 白算 ~97 条命令。start 算一次 end-start 打标志，step 每 tick 只插值有变化的分量。
scoreboard objectives add anim_c_px dummy
scoreboard objectives add anim_c_py dummy
scoreboard objectives add anim_c_pz dummy
scoreboard objectives add anim_c_rx dummy
scoreboard objectives add anim_c_ry dummy
scoreboard objectives add anim_c_rz dummy
scoreboard objectives add anim_c_sx dummy
scoreboard objectives add anim_c_sy dummy
scoreboard objectives add anim_c_sz dummy
# 旋转组变化标志（任一旋转轴有变化 → 1；step 据此跳过 euler_to_quat，直接写单位四元数）
scoreboard objectives add anim_c_rot dummy