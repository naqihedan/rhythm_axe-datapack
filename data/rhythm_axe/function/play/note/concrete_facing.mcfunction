# 混凝土 pitch：rx = atan2(-dy, h)（标准四元数绕X；dy 向上为正、标准绕X正=向下 → 取反）
# 输入：#dir_x / #dir_y / #dir_z play_state（×100，运动方向 = 判定位置 - 起始位置）
# 输出：#ha_rx display_calc（半角×10，供 euler_to_quat 使用）
# 水平距离 h（×100）= sqrt(dx²+dz²)
scoreboard players operation #h2 display_calc = #dir_x play_state
scoreboard players operation #h2 display_calc *= #dir_x play_state
scoreboard players operation #dz2 display_calc = #dir_z play_state
scoreboard players operation #dz2 display_calc *= #dir_z play_state
scoreboard players operation #h2 display_calc += #dz2 display_calc
scoreboard players operation #sqrt_sq display_calc = #h2 display_calc
function rhythm_axe:utilization/math/sqrt
scoreboard players operation #num display_calc = #dir_y play_state
scoreboard players operation #num display_calc *= -1 const
scoreboard players operation #den display_calc = #sqrt_out display_calc
function rhythm_axe:utilization/math/atan2
scoreboard players operation #ha_rx display_calc = #atan_deg100 display_calc
scoreboard players operation #ha_rx display_calc /= 20 const
