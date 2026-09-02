# ========== 平方根近似（二分法）==========
# 输入：#sqrt_sq display_calc = 平方值（×10000 尺度，即 (值×100)²，范围 0 ~ 4e8）
# 输出：#sqrt_out display_calc = 值（×100 尺度）
# 二分区间 [0, 20000]（对应 0 ~ 200 格），14 次迭代（精度 ~0.012 格）
# 用途：音符运动距离、混凝土长条长度等需要 sqrt 的地方
# 注意：#mid2 = #mid×#mid（int 乘法），#mid≤20000 → #mid2≤4e8 不溢出

scoreboard players set #lo display_calc 0
scoreboard players set #hi display_calc 20000

# 迭代 1~14：mid=(lo+hi)/2；if mid²<=sq → lo=mid else hi=mid
scoreboard players operation #mid display_calc = #lo display_calc
scoreboard players operation #mid display_calc += #hi display_calc
scoreboard players operation #mid display_calc /= 2 const
scoreboard players operation #mid2 display_calc = #mid display_calc
scoreboard players operation #mid2 display_calc *= #mid display_calc
execute if score #mid2 display_calc <= #sqrt_sq display_calc run scoreboard players operation #lo display_calc = #mid display_calc
execute if score #mid2 display_calc > #sqrt_sq display_calc run scoreboard players operation #hi display_calc = #mid display_calc

scoreboard players operation #mid display_calc = #lo display_calc
scoreboard players operation #mid display_calc += #hi display_calc
scoreboard players operation #mid display_calc /= 2 const
scoreboard players operation #mid2 display_calc = #mid display_calc
scoreboard players operation #mid2 display_calc *= #mid display_calc
execute if score #mid2 display_calc <= #sqrt_sq display_calc run scoreboard players operation #lo display_calc = #mid display_calc
execute if score #mid2 display_calc > #sqrt_sq display_calc run scoreboard players operation #hi display_calc = #mid display_calc

scoreboard players operation #mid display_calc = #lo display_calc
scoreboard players operation #mid display_calc += #hi display_calc
scoreboard players operation #mid display_calc /= 2 const
scoreboard players operation #mid2 display_calc = #mid display_calc
scoreboard players operation #mid2 display_calc *= #mid display_calc
execute if score #mid2 display_calc <= #sqrt_sq display_calc run scoreboard players operation #lo display_calc = #mid display_calc
execute if score #mid2 display_calc > #sqrt_sq display_calc run scoreboard players operation #hi display_calc = #mid display_calc

scoreboard players operation #mid display_calc = #lo display_calc
scoreboard players operation #mid display_calc += #hi display_calc
scoreboard players operation #mid display_calc /= 2 const
scoreboard players operation #mid2 display_calc = #mid display_calc
scoreboard players operation #mid2 display_calc *= #mid display_calc
execute if score #mid2 display_calc <= #sqrt_sq display_calc run scoreboard players operation #lo display_calc = #mid display_calc
execute if score #mid2 display_calc > #sqrt_sq display_calc run scoreboard players operation #hi display_calc = #mid display_calc

scoreboard players operation #mid display_calc = #lo display_calc
scoreboard players operation #mid display_calc += #hi display_calc
scoreboard players operation #mid display_calc /= 2 const
scoreboard players operation #mid2 display_calc = #mid display_calc
scoreboard players operation #mid2 display_calc *= #mid display_calc
execute if score #mid2 display_calc <= #sqrt_sq display_calc run scoreboard players operation #lo display_calc = #mid display_calc
execute if score #mid2 display_calc > #sqrt_sq display_calc run scoreboard players operation #hi display_calc = #mid display_calc

scoreboard players operation #mid display_calc = #lo display_calc
scoreboard players operation #mid display_calc += #hi display_calc
scoreboard players operation #mid display_calc /= 2 const
scoreboard players operation #mid2 display_calc = #mid display_calc
scoreboard players operation #mid2 display_calc *= #mid display_calc
execute if score #mid2 display_calc <= #sqrt_sq display_calc run scoreboard players operation #lo display_calc = #mid display_calc
execute if score #mid2 display_calc > #sqrt_sq display_calc run scoreboard players operation #hi display_calc = #mid display_calc

scoreboard players operation #mid display_calc = #lo display_calc
scoreboard players operation #mid display_calc += #hi display_calc
scoreboard players operation #mid display_calc /= 2 const
scoreboard players operation #mid2 display_calc = #mid display_calc
scoreboard players operation #mid2 display_calc *= #mid display_calc
execute if score #mid2 display_calc <= #sqrt_sq display_calc run scoreboard players operation #lo display_calc = #mid display_calc
execute if score #mid2 display_calc > #sqrt_sq display_calc run scoreboard players operation #hi display_calc = #mid display_calc

scoreboard players operation #mid display_calc = #lo display_calc
scoreboard players operation #mid display_calc += #hi display_calc
scoreboard players operation #mid display_calc /= 2 const
scoreboard players operation #mid2 display_calc = #mid display_calc
scoreboard players operation #mid2 display_calc *= #mid display_calc
execute if score #mid2 display_calc <= #sqrt_sq display_calc run scoreboard players operation #lo display_calc = #mid display_calc
execute if score #mid2 display_calc > #sqrt_sq display_calc run scoreboard players operation #hi display_calc = #mid display_calc

scoreboard players operation #mid display_calc = #lo display_calc
scoreboard players operation #mid display_calc += #hi display_calc
scoreboard players operation #mid display_calc /= 2 const
scoreboard players operation #mid2 display_calc = #mid display_calc
scoreboard players operation #mid2 display_calc *= #mid display_calc
execute if score #mid2 display_calc <= #sqrt_sq display_calc run scoreboard players operation #lo display_calc = #mid display_calc
execute if score #mid2 display_calc > #sqrt_sq display_calc run scoreboard players operation #hi display_calc = #mid display_calc

scoreboard players operation #mid display_calc = #lo display_calc
scoreboard players operation #mid display_calc += #hi display_calc
scoreboard players operation #mid display_calc /= 2 const
scoreboard players operation #mid2 display_calc = #mid display_calc
scoreboard players operation #mid2 display_calc *= #mid display_calc
execute if score #mid2 display_calc <= #sqrt_sq display_calc run scoreboard players operation #lo display_calc = #mid display_calc
execute if score #mid2 display_calc > #sqrt_sq display_calc run scoreboard players operation #hi display_calc = #mid display_calc

scoreboard players operation #mid display_calc = #lo display_calc
scoreboard players operation #mid display_calc += #hi display_calc
scoreboard players operation #mid display_calc /= 2 const
scoreboard players operation #mid2 display_calc = #mid display_calc
scoreboard players operation #mid2 display_calc *= #mid display_calc
execute if score #mid2 display_calc <= #sqrt_sq display_calc run scoreboard players operation #lo display_calc = #mid display_calc
execute if score #mid2 display_calc > #sqrt_sq display_calc run scoreboard players operation #hi display_calc = #mid display_calc

scoreboard players operation #mid display_calc = #lo display_calc
scoreboard players operation #mid display_calc += #hi display_calc
scoreboard players operation #mid display_calc /= 2 const
scoreboard players operation #mid2 display_calc = #mid display_calc
scoreboard players operation #mid2 display_calc *= #mid display_calc
execute if score #mid2 display_calc <= #sqrt_sq display_calc run scoreboard players operation #lo display_calc = #mid display_calc
execute if score #mid2 display_calc > #sqrt_sq display_calc run scoreboard players operation #hi display_calc = #mid display_calc

scoreboard players operation #mid display_calc = #lo display_calc
scoreboard players operation #mid display_calc += #hi display_calc
scoreboard players operation #mid display_calc /= 2 const
scoreboard players operation #mid2 display_calc = #mid display_calc
scoreboard players operation #mid2 display_calc *= #mid display_calc
execute if score #mid2 display_calc <= #sqrt_sq display_calc run scoreboard players operation #lo display_calc = #mid display_calc
execute if score #mid2 display_calc > #sqrt_sq display_calc run scoreboard players operation #hi display_calc = #mid display_calc

scoreboard players operation #mid display_calc = #lo display_calc
scoreboard players operation #mid display_calc += #hi display_calc
scoreboard players operation #mid display_calc /= 2 const
scoreboard players operation #mid2 display_calc = #mid display_calc
scoreboard players operation #mid2 display_calc *= #mid display_calc
execute if score #mid2 display_calc <= #sqrt_sq display_calc run scoreboard players operation #lo display_calc = #mid display_calc
execute if score #mid2 display_calc > #sqrt_sq display_calc run scoreboard players operation #hi display_calc = #mid display_calc

scoreboard players operation #mid display_calc = #lo display_calc
scoreboard players operation #mid display_calc += #hi display_calc
scoreboard players operation #mid display_calc /= 2 const
scoreboard players operation #mid2 display_calc = #mid display_calc
scoreboard players operation #mid2 display_calc *= #mid display_calc
execute if score #mid2 display_calc <= #sqrt_sq display_calc run scoreboard players operation #lo display_calc = #mid display_calc
execute if score #mid2 display_calc > #sqrt_sq display_calc run scoreboard players operation #hi display_calc = #mid display_calc

scoreboard players operation #sqrt_out display_calc = #lo display_calc
