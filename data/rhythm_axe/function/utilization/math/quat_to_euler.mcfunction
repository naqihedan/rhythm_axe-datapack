# ========== 四元数 → ZYX 欧拉角 ==========
# 读取 @s 的 left_rotation，写入 display_calc 的 #cur_rx/ry/rz（角度×1，360°=360）

# ===== 1. 读取四元数 =====
execute store result score #qx display_calc run data get entity @s transformation.left_rotation[0] 10000
execute store result score #qy display_calc run data get entity @s transformation.left_rotation[1] 10000
execute store result score #qz display_calc run data get entity @s transformation.left_rotation[2] 10000
execute store result score #qw display_calc run data get entity @s transformation.left_rotation[3] 10000

# ===== 2. 计算中间值（先乘后除，避免精度丢失）=====
# sin_ry = 2*(qw*qy - qx*qz) / 10000  (×10000 格式)
scoreboard players operation #t1 display_calc = #qw display_calc
scoreboard players operation #t1 display_calc *= #qy display_calc
scoreboard players operation #t2 display_calc = #qx display_calc
scoreboard players operation #t2 display_calc *= #qz display_calc
scoreboard players operation #sin_ry display_calc = #t1 display_calc
scoreboard players operation #sin_ry display_calc -= #t2 display_calc
scoreboard players operation #sin_ry display_calc *= 2 const
scoreboard players operation #sin_ry display_calc /= 10000 const

# rx_num = 2*(qw*qx + qy*qz) / 10000  (×10000 格式)
scoreboard players operation #t1 display_calc = #qw display_calc
scoreboard players operation #t1 display_calc *= #qx display_calc
scoreboard players operation #t2 display_calc = #qy display_calc
scoreboard players operation #t2 display_calc *= #qz display_calc
scoreboard players operation #rx_num display_calc = #t1 display_calc
scoreboard players operation #rx_num display_calc += #t2 display_calc
scoreboard players operation #rx_num display_calc *= 2 const
scoreboard players operation #rx_num display_calc /= 10000 const

# rx_den = (qw² - qx² - qy² + qz²) / 10000  (×10000 格式)
scoreboard players operation #t1 display_calc = #qw display_calc
scoreboard players operation #t1 display_calc *= #qw display_calc
scoreboard players operation #t2 display_calc = #qx display_calc
scoreboard players operation #t2 display_calc *= #qx display_calc
scoreboard players operation #t3 display_calc = #qy display_calc
scoreboard players operation #t3 display_calc *= #qy display_calc
scoreboard players operation #t4 display_calc = #qz display_calc
scoreboard players operation #t4 display_calc *= #qz display_calc
scoreboard players operation #rx_den display_calc = #t1 display_calc
scoreboard players operation #rx_den display_calc -= #t2 display_calc
scoreboard players operation #rx_den display_calc -= #t3 display_calc
scoreboard players operation #rx_den display_calc += #t4 display_calc
scoreboard players operation #rx_den display_calc /= 10000 const

# rz_num = 2*(qw*qz + qx*qy) / 10000  (×10000 格式)
scoreboard players operation #t1 display_calc = #qw display_calc
scoreboard players operation #t1 display_calc *= #qz display_calc
scoreboard players operation #t2 display_calc = #qx display_calc
scoreboard players operation #t2 display_calc *= #qy display_calc
scoreboard players operation #rz_num display_calc = #t1 display_calc
scoreboard players operation #rz_num display_calc += #t2 display_calc
scoreboard players operation #rz_num display_calc *= 2 const
scoreboard players operation #rz_num display_calc /= 10000 const

# rz_den = (qw² + qx² - qy² - qz²) / 10000  (×10000 格式)
scoreboard players operation #rz_den display_calc = #qw display_calc
scoreboard players operation #rz_den display_calc *= #qw display_calc
scoreboard players operation #t2 display_calc = #qx display_calc
scoreboard players operation #t2 display_calc *= #qx display_calc
scoreboard players operation #rz_den display_calc += #t2 display_calc
scoreboard players operation #t3 display_calc = #qy display_calc
scoreboard players operation #t3 display_calc *= #qy display_calc
scoreboard players operation #rz_den display_calc -= #t3 display_calc
scoreboard players operation #t4 display_calc = #qz display_calc
scoreboard players operation #t4 display_calc *= #qz display_calc
scoreboard players operation #rz_den display_calc -= #t4 display_calc
scoreboard players operation #rz_den display_calc /= 10000 const

# ===== 3. 求 ry = asin(sin_ry) 近似（度×100）=====
# asin(x) ≈ x + x³/6 + 3x⁵/40 （弧度），再转度×100
scoreboard players operation #abs_sin_ry display_calc = #sin_ry display_calc
execute if score #abs_sin_ry display_calc matches ..-1 run scoreboard players operation #abs_sin_ry display_calc *= -1 const

scoreboard players operation #x2 display_calc = #abs_sin_ry display_calc
scoreboard players operation #x2 display_calc *= #abs_sin_ry display_calc
scoreboard players operation #x2 display_calc /= 10000 const
scoreboard players operation #x3 display_calc = #x2 display_calc
scoreboard players operation #x3 display_calc *= #abs_sin_ry display_calc
scoreboard players operation #x3 display_calc /= 10000 const
scoreboard players operation #x5 display_calc = #x3 display_calc
scoreboard players operation #x5 display_calc *= #x2 display_calc
scoreboard players operation #x5 display_calc /= 10000 const

# asin_rad_10000 = x + x³/6 + 3x⁵/40
# x
scoreboard players operation #asin_rad display_calc = #abs_sin_ry display_calc
# + x³/6
scoreboard players operation #t3_6 display_calc = #x3 display_calc
scoreboard players operation #t3_6 display_calc /= 6 const
scoreboard players operation #asin_rad display_calc += #t3_6 display_calc
# + 3x⁵/40
scoreboard players operation #t5_40 display_calc = #x5 display_calc
scoreboard players operation #t5_40 display_calc *= 3 const
scoreboard players operation #t5_40 display_calc /= 40 const
scoreboard players operation #asin_rad display_calc += #t5_40 display_calc

# 弧度转度×100：×57296/100000
scoreboard players operation #asin_deg100 display_calc = #asin_rad display_calc
scoreboard players operation #asin_deg100 display_calc *= 57296 const
scoreboard players operation #asin_deg100 display_calc /= 100000 const
execute if score #sin_ry display_calc matches ..-1 run scoreboard players operation #asin_deg100 display_calc *= -1 const
# 转为度×1
scoreboard players operation #cur_ry display_calc = #asin_deg100 display_calc
scoreboard players operation #cur_ry display_calc /= 100 const

# ===== 4. 求 rx = atan2(rx_num, rx_den) =====
scoreboard players operation #num display_calc = #rx_num display_calc
scoreboard players operation #den display_calc = #rx_den display_calc
function rhythm_axe:utilization/math/atan2
# atan2 输出度×100，转为度×1
scoreboard players operation #cur_rx display_calc = #atan_deg100 display_calc
scoreboard players operation #cur_rx display_calc /= 100 const

# ===== 5. 求 rz = atan2(rz_num, rz_den) =====
scoreboard players operation #num display_calc = #rz_num display_calc
scoreboard players operation #den display_calc = #rz_den display_calc
function rhythm_axe:utilization/math/atan2
# atan2 输出度×100，转为度×1
scoreboard players operation #cur_rz display_calc = #atan_deg100 display_calc
scoreboard players operation #cur_rz display_calc /= 100 const

# ===== 6. 规格化到 0~360 =====
execute if score #cur_rx display_calc matches ..-1 run scoreboard players add #cur_rx display_calc 360
execute if score #cur_rx display_calc matches 360.. run scoreboard players operation #cur_rx display_calc %= 360 const
execute if score #cur_ry display_calc matches ..-1 run scoreboard players add #cur_ry display_calc 360
execute if score #cur_ry display_calc matches 360.. run scoreboard players operation #cur_ry display_calc %= 360 const
execute if score #cur_rz display_calc matches ..-1 run scoreboard players add #cur_rz display_calc 360
execute if score #cur_rz display_calc matches 360.. run scoreboard players operation #cur_rz display_calc %= 360 const
