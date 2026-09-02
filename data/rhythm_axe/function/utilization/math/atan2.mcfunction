# ========== atan2 近似计算 ==========
# 输入：#num, #den（×10000）
# 输出：#atan_deg100（度×100，范围 -18000~18000）
# 使用 atan(z) ≈ z - z³/3 + z⁵/5（弧度），再转度×100

# 处理特殊情况
execute if score #den display_calc matches 0 if score #num display_calc matches 0 run scoreboard players set #atan_deg100 display_calc 0
execute if score #den display_calc matches 0 if score #num display_calc matches 0 run return 0
execute if score #den display_calc matches 0 if score #num display_calc matches 1.. run scoreboard players set #atan_deg100 display_calc 9000
execute if score #den display_calc matches 0 if score #num display_calc matches 1.. run return 0
execute if score #den display_calc matches 0 if score #num display_calc matches ..-1 run scoreboard players set #atan_deg100 display_calc -9000
execute if score #den display_calc matches 0 if score #num display_calc matches ..-1 run return 0

# 确定象限
scoreboard players set #quadrant display_calc 0
execute if score #den display_calc matches ..-1 run scoreboard players set #quadrant display_calc 1

# 计算 |z| = |num/den|（×10000）
scoreboard players operation #z display_calc = #num display_calc
execute if score #z display_calc matches ..-1 run scoreboard players operation #z display_calc *= -1 const
scoreboard players operation #abs_den display_calc = #den display_calc
execute if score #abs_den display_calc matches ..-1 run scoreboard players operation #abs_den display_calc *= -1 const

# 若 |num| > |den|，用 atan(|den/num|)（处理 >45° 的情况）
scoreboard players set #swap display_calc 0
execute if score #z display_calc > #abs_den display_calc run scoreboard players set #swap display_calc 1
# swap z 和 abs_den：z = |den|, abs_den = |num|
execute if score #swap display_calc matches 1 run scoreboard players operation #t1 display_calc = #z display_calc
execute if score #swap display_calc matches 1 run scoreboard players operation #z display_calc = #abs_den display_calc
execute if score #swap display_calc matches 1 run scoreboard players operation #abs_den display_calc = #t1 display_calc

# 计算 z = |num| / |den|（×10000）
scoreboard players operation #z display_calc = #z display_calc
scoreboard players operation #z display_calc *= 10000 const
execute if score #abs_den display_calc matches 1.. run scoreboard players operation #z display_calc /= #abs_den display_calc

# 若 z > 10000（即 |num| > |den|），限制到 10000
execute if score #z display_calc matches 10001.. run scoreboard players set #z display_calc 10000

# atan(z) ≈ z / (1 + 0.28125·z²)（有理近似，|z|≤1 全范围误差 <0.3°；替换收敛慢的泰勒级数——泰勒在 z≈1（45°）处误差可达 3°）
# 实现（×10000）：#z2 = z²×10000；#den2 = 10000 + 2812×#z2/10000；#atan_rad = #z×10000 / #den2
scoreboard players operation #z2 display_calc = #z display_calc
scoreboard players operation #z2 display_calc *= #z display_calc
scoreboard players operation #z2 display_calc /= 10000 const
scoreboard players operation #den2 display_calc = #z2 display_calc
scoreboard players operation #den2 display_calc *= 2812 const
scoreboard players operation #den2 display_calc /= 10000 const
scoreboard players operation #den2 display_calc += 10000 const
scoreboard players operation #atan_rad display_calc = #z display_calc
scoreboard players operation #atan_rad display_calc *= 10000 const
scoreboard players operation #atan_rad display_calc /= #den2 display_calc

# 若 swap=1（即原 |num| > |den|），用 atan(1/z) = π/2 - atan(z)
# π/2 弧度 × 10000 = 15708
execute if score #swap display_calc matches 1 run scoreboard players operation #t1 display_calc = 15708 const
execute if score #swap display_calc matches 1 run scoreboard players operation #t1 display_calc -= #atan_rad display_calc
execute if score #swap display_calc matches 1 run scoreboard players operation #atan_rad display_calc = #t1 display_calc

# 弧度转度×100（rad_x10000 × 1.8/π → degree_x100）
scoreboard players operation #atan_deg100 display_calc = #atan_rad display_calc
scoreboard players operation #atan_deg100 display_calc *= 57296 const
scoreboard players operation #atan_deg100 display_calc /= 100000 const

# 象限调整
# den<0, num>=0: atan2 = 180° - atan(num/den) → 18000 - atan_deg100
execute if score #quadrant display_calc matches 1 if score #num display_calc matches 0.. run scoreboard players operation #atan_deg100 display_calc *= -1 const
execute if score #quadrant display_calc matches 1 if score #num display_calc matches 0.. run scoreboard players add #atan_deg100 display_calc 18000
# den<0, num<0: atan2 = -180° + atan(num/den) → -(18000 - atan_deg100)
execute if score #quadrant display_calc matches 1 if score #num display_calc matches ..-1 run scoreboard players operation #atan_deg100 display_calc *= -1 const
execute if score #quadrant display_calc matches 1 if score #num display_calc matches ..-1 run scoreboard players add #atan_deg100 display_calc 18000
execute if score #quadrant display_calc matches 1 if score #num display_calc matches ..-1 run scoreboard players operation #atan_deg100 display_calc *= -1 const

# 符号：num 为负且 quadrant=0 时取反
execute if score #num display_calc matches ..-1 if score #quadrant display_calc matches 0 run scoreboard players operation #atan_deg100 display_calc *= -1 const
