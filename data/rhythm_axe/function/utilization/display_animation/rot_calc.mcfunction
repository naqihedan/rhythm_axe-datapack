# 旋转计算子函数（仅当 @s anim_c_rot=1 有旋转变化时被 step 调用）
# 含：半角计算 + 三角函数查表 + 欧拉角→四元数 + 记录当前欧拉角
# ★ 优化（2026-08-09）：音符旋转恒为单位四元数（anim_c_rot=0）→ step 直接写单位四元数，
#   不调用本函数 → 省 半角9 + 查表6 + euler_to_quat~40 ≈ 59 条/实体/tick

# ===== 半角计算 =====
# 角度存的是度×1，360° = 360（精度 1°）
# cur×5 = 半角度×10，然后归一化到 0~3599（对应 0°~359.9°），查 3600 项三角函数表
scoreboard players operation #ha_rx display_calc = #cur_rx display_calc
scoreboard players operation #ha_rx display_calc *= 5 const
scoreboard players operation #ha_rx display_calc %= 3600 const
scoreboard players operation #ha_ry display_calc = #cur_ry display_calc
scoreboard players operation #ha_ry display_calc *= 5 const
scoreboard players operation #ha_ry display_calc %= 3600 const
scoreboard players operation #ha_rz display_calc = #cur_rz display_calc
scoreboard players operation #ha_rz display_calc *= 5 const
scoreboard players operation #ha_rz display_calc %= 3600 const

# ===== 欧拉角转四元数 (ZYX顺序) =====
function rhythm_axe:utilization/math/euler_to_quat

# ===== 更新实体当前欧拉角记录 =====
scoreboard players operation @s anim_cur_rx = #cur_rx display_calc
scoreboard players operation @s anim_cur_ry = #cur_ry display_calc
scoreboard players operation @s anim_cur_rz = #cur_rz display_calc
