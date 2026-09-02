# ========== 缓动幂运算 ==========
# 输入（display_calc 计分板）：
#   #n = 当前步数, #total = 总步数, #power = 幂次 (1~5), #easing_type = 类型 (1/2/3)
# 输出：#ratio = 缓动进度 (0~10000)
# 每步乘法后立即除以 10000，防止整数溢出。
#
# 类型 1（缓入）：ratio = (n/total)^power
# 类型 2（缓出）：ratio = 1 - (1 - n/total)^power
# 类型 3（缓入缓出）：前半 = (2n/total)^power / 2，后半 = 1 - (2-2n/total)^power / 2

# ===== 基础进度 =====
scoreboard players operation #x display_calc = #n display_calc
scoreboard players operation #x display_calc *= 10000 const
scoreboard players operation #x display_calc /= #total display_calc

# ===== 类型 3：计算半程分界点 =====
execute if score #easing_type display_calc matches 3 run scoreboard players operation #half display_calc = #total display_calc
execute if score #easing_type display_calc matches 3 run scoreboard players operation #half display_calc /= 2 const

# ===== 类型 3：缩放 x 到 [0,10000] 范围 =====
# 前半（n <= half）：x = x * 2（0~5000 → 0~10000）
execute if score #easing_type display_calc matches 3 if score #n display_calc <= #half display_calc run scoreboard players operation #x display_calc *= 2 const
# 后半（n > half）：x = x * 2 - 10000（5001~10000 → 2~10000）
execute if score #easing_type display_calc matches 3 if score #n display_calc > #half display_calc run scoreboard players operation #x display_calc *= 2 const
execute if score #easing_type display_calc matches 3 if score #n display_calc > #half display_calc run scoreboard players operation #x display_calc -= 10000 const

# ===== 幂运算：x_pow = x^power =====
execute if score #power display_calc matches 1 run scoreboard players operation #x_pow display_calc = #x display_calc

execute if score #power display_calc matches 2 run scoreboard players operation #t display_calc = #x display_calc
execute if score #power display_calc matches 2 run scoreboard players operation #t display_calc *= #x display_calc
execute if score #power display_calc matches 2 run scoreboard players operation #t display_calc /= 10000 const
execute if score #power display_calc matches 2 run scoreboard players operation #x_pow display_calc = #t display_calc

execute if score #power display_calc matches 3 run scoreboard players operation #t display_calc = #x display_calc
execute if score #power display_calc matches 3 run scoreboard players operation #t display_calc *= #x display_calc
execute if score #power display_calc matches 3 run scoreboard players operation #t display_calc /= 10000 const
execute if score #power display_calc matches 3 run scoreboard players operation #t display_calc *= #x display_calc
execute if score #power display_calc matches 3 run scoreboard players operation #t display_calc /= 10000 const
execute if score #power display_calc matches 3 run scoreboard players operation #x_pow display_calc = #t display_calc

execute if score #power display_calc matches 4 run scoreboard players operation #t display_calc = #x display_calc
execute if score #power display_calc matches 4 run scoreboard players operation #t display_calc *= #x display_calc
execute if score #power display_calc matches 4 run scoreboard players operation #t display_calc /= 10000 const
execute if score #power display_calc matches 4 run scoreboard players operation #t display_calc *= #x display_calc
execute if score #power display_calc matches 4 run scoreboard players operation #t display_calc /= 10000 const
execute if score #power display_calc matches 4 run scoreboard players operation #t display_calc *= #x display_calc
execute if score #power display_calc matches 4 run scoreboard players operation #t display_calc /= 10000 const
execute if score #power display_calc matches 4 run scoreboard players operation #x_pow display_calc = #t display_calc

execute if score #power display_calc matches 5 run scoreboard players operation #t display_calc = #x display_calc
execute if score #power display_calc matches 5 run scoreboard players operation #t display_calc *= #x display_calc
execute if score #power display_calc matches 5 run scoreboard players operation #t display_calc /= 10000 const
execute if score #power display_calc matches 5 run scoreboard players operation #t display_calc *= #x display_calc
execute if score #power display_calc matches 5 run scoreboard players operation #t display_calc /= 10000 const
execute if score #power display_calc matches 5 run scoreboard players operation #t display_calc *= #x display_calc
execute if score #power display_calc matches 5 run scoreboard players operation #t display_calc /= 10000 const
execute if score #power display_calc matches 5 run scoreboard players operation #t display_calc *= #x display_calc
execute if score #power display_calc matches 5 run scoreboard players operation #t display_calc /= 10000 const
execute if score #power display_calc matches 5 run scoreboard players operation #x_pow display_calc = #t display_calc

execute unless score #power display_calc matches 1..5 run scoreboard players operation #x_pow display_calc = #x display_calc

# ===== 类型 2 和类型 3 后半段：计算 rev_pow = (10000-x)^power =====
# 用于缓出（类型 2）和缓入缓出后半段（类型 3）
execute if score #easing_type display_calc matches 2 run scoreboard players operation #x_rev display_calc = 10000 const
execute if score #easing_type display_calc matches 2 run scoreboard players operation #x_rev display_calc -= #x display_calc

execute if score #easing_type display_calc matches 3 if score #n display_calc > #half display_calc run scoreboard players operation #x_rev display_calc = 10000 const
execute if score #easing_type display_calc matches 3 if score #n display_calc > #half display_calc run scoreboard players operation #x_rev display_calc -= #x display_calc

execute if score #easing_type display_calc matches 2 run scoreboard players operation #rev_pow display_calc = #x_rev display_calc
execute if score #easing_type display_calc matches 3 if score #n display_calc > #half display_calc run scoreboard players operation #rev_pow display_calc = #x_rev display_calc

execute if score #power display_calc matches 1 if score #easing_type display_calc matches 2 run scoreboard players operation #rev_pow display_calc = #x_rev display_calc
execute if score #power display_calc matches 1 if score #easing_type display_calc matches 3 if score #n display_calc > #half display_calc run scoreboard players operation #rev_pow display_calc = #x_rev display_calc

execute if score #easing_type display_calc matches 3 if score #n display_calc > #half display_calc if score #power display_calc matches 2 run scoreboard players operation #t display_calc = #x_rev display_calc
execute if score #easing_type display_calc matches 3 if score #n display_calc > #half display_calc if score #power display_calc matches 2 run scoreboard players operation #t display_calc *= #x_rev display_calc
execute if score #easing_type display_calc matches 3 if score #n display_calc > #half display_calc if score #power display_calc matches 2 run scoreboard players operation #t display_calc /= 10000 const
execute if score #easing_type display_calc matches 3 if score #n display_calc > #half display_calc if score #power display_calc matches 2 run scoreboard players operation #rev_pow display_calc = #t display_calc

execute if score #easing_type display_calc matches 2 if score #power display_calc matches 2 run scoreboard players operation #t display_calc = #x_rev display_calc
execute if score #easing_type display_calc matches 2 if score #power display_calc matches 2 run scoreboard players operation #t display_calc *= #x_rev display_calc
execute if score #easing_type display_calc matches 2 if score #power display_calc matches 2 run scoreboard players operation #t display_calc /= 10000 const
execute if score #easing_type display_calc matches 2 if score #power display_calc matches 2 run scoreboard players operation #rev_pow display_calc = #t display_calc

execute if score #easing_type display_calc matches 3 if score #n display_calc > #half display_calc if score #power display_calc matches 3 run scoreboard players operation #t display_calc = #x_rev display_calc
execute if score #easing_type display_calc matches 3 if score #n display_calc > #half display_calc if score #power display_calc matches 3 run scoreboard players operation #t display_calc *= #x_rev display_calc
execute if score #easing_type display_calc matches 3 if score #n display_calc > #half display_calc if score #power display_calc matches 3 run scoreboard players operation #t display_calc /= 10000 const
execute if score #easing_type display_calc matches 3 if score #n display_calc > #half display_calc if score #power display_calc matches 3 run scoreboard players operation #t display_calc *= #x_rev display_calc
execute if score #easing_type display_calc matches 3 if score #n display_calc > #half display_calc if score #power display_calc matches 3 run scoreboard players operation #t display_calc /= 10000 const
execute if score #easing_type display_calc matches 3 if score #n display_calc > #half display_calc if score #power display_calc matches 3 run scoreboard players operation #rev_pow display_calc = #t display_calc

execute if score #easing_type display_calc matches 2 if score #power display_calc matches 3 run scoreboard players operation #t display_calc = #x_rev display_calc
execute if score #easing_type display_calc matches 2 if score #power display_calc matches 3 run scoreboard players operation #t display_calc *= #x_rev display_calc
execute if score #easing_type display_calc matches 2 if score #power display_calc matches 3 run scoreboard players operation #t display_calc /= 10000 const
execute if score #easing_type display_calc matches 2 if score #power display_calc matches 3 run scoreboard players operation #t display_calc *= #x_rev display_calc
execute if score #easing_type display_calc matches 2 if score #power display_calc matches 3 run scoreboard players operation #t display_calc /= 10000 const
execute if score #easing_type display_calc matches 2 if score #power display_calc matches 3 run scoreboard players operation #rev_pow display_calc = #t display_calc

execute if score #easing_type display_calc matches 3 if score #n display_calc > #half display_calc if score #power display_calc matches 4 run scoreboard players operation #t display_calc = #x_rev display_calc
execute if score #easing_type display_calc matches 3 if score #n display_calc > #half display_calc if score #power display_calc matches 4 run scoreboard players operation #t display_calc *= #x_rev display_calc
execute if score #easing_type display_calc matches 3 if score #n display_calc > #half display_calc if score #power display_calc matches 4 run scoreboard players operation #t display_calc /= 10000 const
execute if score #easing_type display_calc matches 3 if score #n display_calc > #half display_calc if score #power display_calc matches 4 run scoreboard players operation #t display_calc *= #x_rev display_calc
execute if score #easing_type display_calc matches 3 if score #n display_calc > #half display_calc if score #power display_calc matches 4 run scoreboard players operation #t display_calc /= 10000 const
execute if score #easing_type display_calc matches 3 if score #n display_calc > #half display_calc if score #power display_calc matches 4 run scoreboard players operation #t display_calc *= #x_rev display_calc
execute if score #easing_type display_calc matches 3 if score #n display_calc > #half display_calc if score #power display_calc matches 4 run scoreboard players operation #t display_calc /= 10000 const
execute if score #easing_type display_calc matches 3 if score #n display_calc > #half display_calc if score #power display_calc matches 4 run scoreboard players operation #rev_pow display_calc = #t display_calc

execute if score #easing_type display_calc matches 2 if score #power display_calc matches 4 run scoreboard players operation #t display_calc = #x_rev display_calc
execute if score #easing_type display_calc matches 2 if score #power display_calc matches 4 run scoreboard players operation #t display_calc *= #x_rev display_calc
execute if score #easing_type display_calc matches 2 if score #power display_calc matches 4 run scoreboard players operation #t display_calc /= 10000 const
execute if score #easing_type display_calc matches 2 if score #power display_calc matches 4 run scoreboard players operation #t display_calc *= #x_rev display_calc
execute if score #easing_type display_calc matches 2 if score #power display_calc matches 4 run scoreboard players operation #t display_calc /= 10000 const
execute if score #easing_type display_calc matches 2 if score #power display_calc matches 4 run scoreboard players operation #t display_calc *= #x_rev display_calc
execute if score #easing_type display_calc matches 2 if score #power display_calc matches 4 run scoreboard players operation #t display_calc /= 10000 const
execute if score #easing_type display_calc matches 2 if score #power display_calc matches 4 run scoreboard players operation #rev_pow display_calc = #t display_calc

execute if score #easing_type display_calc matches 3 if score #n display_calc > #half display_calc if score #power display_calc matches 5 run scoreboard players operation #t display_calc = #x_rev display_calc
execute if score #easing_type display_calc matches 3 if score #n display_calc > #half display_calc if score #power display_calc matches 5 run scoreboard players operation #t display_calc *= #x_rev display_calc
execute if score #easing_type display_calc matches 3 if score #n display_calc > #half display_calc if score #power display_calc matches 5 run scoreboard players operation #t display_calc /= 10000 const
execute if score #easing_type display_calc matches 3 if score #n display_calc > #half display_calc if score #power display_calc matches 5 run scoreboard players operation #t display_calc *= #x_rev display_calc
execute if score #easing_type display_calc matches 3 if score #n display_calc > #half display_calc if score #power display_calc matches 5 run scoreboard players operation #t display_calc /= 10000 const
execute if score #easing_type display_calc matches 3 if score #n display_calc > #half display_calc if score #power display_calc matches 5 run scoreboard players operation #t display_calc *= #x_rev display_calc
execute if score #easing_type display_calc matches 3 if score #n display_calc > #half display_calc if score #power display_calc matches 5 run scoreboard players operation #t display_calc /= 10000 const
execute if score #easing_type display_calc matches 3 if score #n display_calc > #half display_calc if score #power display_calc matches 5 run scoreboard players operation #t display_calc *= #x_rev display_calc
execute if score #easing_type display_calc matches 3 if score #n display_calc > #half display_calc if score #power display_calc matches 5 run scoreboard players operation #t display_calc /= 10000 const
execute if score #easing_type display_calc matches 3 if score #n display_calc > #half display_calc if score #power display_calc matches 5 run scoreboard players operation #rev_pow display_calc = #t display_calc

execute if score #easing_type display_calc matches 2 if score #power display_calc matches 5 run scoreboard players operation #t display_calc = #x_rev display_calc
execute if score #easing_type display_calc matches 2 if score #power display_calc matches 5 run scoreboard players operation #t display_calc *= #x_rev display_calc
execute if score #easing_type display_calc matches 2 if score #power display_calc matches 5 run scoreboard players operation #t display_calc /= 10000 const
execute if score #easing_type display_calc matches 2 if score #power display_calc matches 5 run scoreboard players operation #t display_calc *= #x_rev display_calc
execute if score #easing_type display_calc matches 2 if score #power display_calc matches 5 run scoreboard players operation #t display_calc /= 10000 const
execute if score #easing_type display_calc matches 2 if score #power display_calc matches 5 run scoreboard players operation #t display_calc *= #x_rev display_calc
execute if score #easing_type display_calc matches 2 if score #power display_calc matches 5 run scoreboard players operation #t display_calc /= 10000 const
execute if score #easing_type display_calc matches 2 if score #power display_calc matches 5 run scoreboard players operation #t display_calc *= #x_rev display_calc
execute if score #easing_type display_calc matches 2 if score #power display_calc matches 5 run scoreboard players operation #t display_calc /= 10000 const
execute if score #easing_type display_calc matches 2 if score #power display_calc matches 5 run scoreboard players operation #rev_pow display_calc = #t display_calc

execute if score #easing_type display_calc matches 3 if score #n display_calc > #half display_calc unless score #power display_calc matches 1..5 run scoreboard players operation #rev_pow display_calc = #x_rev display_calc

execute if score #easing_type display_calc matches 2 unless score #power display_calc matches 1..5 run scoreboard players operation #rev_pow display_calc = #x_rev display_calc

# ===== 根据缓动类型输出 =====
# 类型 1（缓入）：ratio = x_pow
execute if score #easing_type display_calc matches 1 run scoreboard players operation #ratio display_calc = #x_pow display_calc

# 类型 1（缓入）：ratio = x_pow = (n/total)^power
# ★ 2026-09-01 补：此前类型 1 漏算 #ratio（残留旧值），power=1 时也出现可见缓动
execute if score #easing_type display_calc matches 1 run scoreboard players operation #ratio display_calc = #x_pow display_calc

# 类型 2（缓出）：ratio = 10000 - rev_pow（rev_pow = (10000-x)^power）
execute if score #easing_type display_calc matches 2 run scoreboard players operation #ratio display_calc = 10000 const
execute if score #easing_type display_calc matches 2 run scoreboard players operation #ratio display_calc -= #rev_pow display_calc

# 类型 3（缓入缓出）
# 前半：ratio = x_pow / 2
execute if score #easing_type display_calc matches 3 if score #n display_calc <= #half display_calc run scoreboard players operation #ratio display_calc = #x_pow display_calc
execute if score #easing_type display_calc matches 3 if score #n display_calc <= #half display_calc run scoreboard players operation #ratio display_calc /= 2 const
# 后半：ratio = 5000 + (10000 - rev_pow) / 2
execute if score #easing_type display_calc matches 3 if score #n display_calc > #half display_calc run scoreboard players operation #ratio display_calc = 10000 const
execute if score #easing_type display_calc matches 3 if score #n display_calc > #half display_calc run scoreboard players operation #ratio display_calc -= #rev_pow display_calc
execute if score #easing_type display_calc matches 3 if score #n display_calc > #half display_calc run scoreboard players operation #ratio display_calc /= 2 const
execute if score #easing_type display_calc matches 3 if score #n display_calc > #half display_calc run scoreboard players operation #ratio display_calc += 5000 const

# 默认（线性）
execute unless score #easing_type display_calc matches 1..3 run scoreboard players operation #ratio display_calc = #x display_calc