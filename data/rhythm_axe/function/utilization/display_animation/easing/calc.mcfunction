# ========== 进度计算 ==========
# 调用前需要设置 #n（当前步数）、#total（总步数）、#power（幂次）到 display_calc 计分板。
# 调用后 #ratio（display_calc）即为缓动进度，取值 0～10000。
# 支持幂次 1～5，超出默认按 1 次方处理（线性）。
# 每步乘法后立即除以 10000，防止整数溢出。

# 计算基础进度 ratio = (n / total) * 10000
scoreboard players operation #ratio display_calc = #n display_calc
scoreboard players operation #ratio display_calc *= 10000 const
scoreboard players operation #ratio display_calc /= #total display_calc

# 根据幂次 power 计算结果，power=1 直接使用 ratio
execute if score #power display_calc matches 1 run scoreboard players operation #ratio display_calc = #ratio display_calc

# power=2: ratio^2
execute if score #power display_calc matches 2 run scoreboard players operation #t display_calc = #ratio display_calc
execute if score #power display_calc matches 2 run scoreboard players operation #t display_calc *= #ratio display_calc
execute if score #power display_calc matches 2 run scoreboard players operation #t display_calc /= 10000 const
execute if score #power display_calc matches 2 run scoreboard players operation #ratio display_calc = #t display_calc

# power=3: ratio^3
execute if score #power display_calc matches 3 run scoreboard players operation #t display_calc = #ratio display_calc
execute if score #power display_calc matches 3 run scoreboard players operation #t display_calc *= #ratio display_calc
execute if score #power display_calc matches 3 run scoreboard players operation #t display_calc /= 10000 const
execute if score #power display_calc matches 3 run scoreboard players operation #t display_calc *= #ratio display_calc
execute if score #power display_calc matches 3 run scoreboard players operation #t display_calc /= 10000 const
execute if score #power display_calc matches 3 run scoreboard players operation #ratio display_calc = #t display_calc

# power=4: ratio^4
execute if score #power display_calc matches 4 run scoreboard players operation #t display_calc = #ratio display_calc
execute if score #power display_calc matches 4 run scoreboard players operation #t display_calc *= #ratio display_calc
execute if score #power display_calc matches 4 run scoreboard players operation #t display_calc /= 10000 const
execute if score #power display_calc matches 4 run scoreboard players operation #t display_calc *= #ratio display_calc
execute if score #power display_calc matches 4 run scoreboard players operation #t display_calc /= 10000 const
execute if score #power display_calc matches 4 run scoreboard players operation #t display_calc *= #ratio display_calc
execute if score #power display_calc matches 4 run scoreboard players operation #t display_calc /= 10000 const
execute if score #power display_calc matches 4 run scoreboard players operation #ratio display_calc = #t display_calc

# power=5: ratio^5
execute if score #power display_calc matches 5 run scoreboard players operation #t display_calc = #ratio display_calc
execute if score #power display_calc matches 5 run scoreboard players operation #t display_calc *= #ratio display_calc
execute if score #power display_calc matches 5 run scoreboard players operation #t display_calc /= 10000 const
execute if score #power display_calc matches 5 run scoreboard players operation #t display_calc *= #ratio display_calc
execute if score #power display_calc matches 5 run scoreboard players operation #t display_calc /= 10000 const
execute if score #power display_calc matches 5 run scoreboard players operation #t display_calc *= #ratio display_calc
execute if score #power display_calc matches 5 run scoreboard players operation #t display_calc /= 10000 const
execute if score #power display_calc matches 5 run scoreboard players operation #t display_calc *= #ratio display_calc
execute if score #power display_calc matches 5 run scoreboard players operation #t display_calc /= 10000 const
execute if score #power display_calc matches 5 run scoreboard players operation #ratio display_calc = #t display_calc