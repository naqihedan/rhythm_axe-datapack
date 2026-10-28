# ========== 示例装饰（decor/example）：关键帧 ==========
# 每帧只在【帧首刻】下发一次：守卫写成精确值 1 / 11 / 21 / 31，【不要写区间】。
#   写区间（如 1..10）会在静止期反复 merge 同一个值 —— 每一次 data merge 都会让客户端
#   重启插值 ⇒ 视觉抽搐 + 白烧指令（这是本仓已记录多次的坑）。
# interpolation_duration = 10 = 帧间隔 ⇒ 客户端把「当前值」插到这一帧的新值，正好占满 10 刻。
# ★ 只在帧首写 translation：scale / left_rotation 在 summon 时已定，重复写属无效 merge。
# ★ 实体 Pos 全在锚点 (6, 5, 19)，位置差写在 transformation.translation
#   （left_rotation 为恒等 ⇒ translation 就是世界轴偏移：+X / +Z / -X / -Z）。
# 帧序（s0 白 / s1 橙 / s2 紫 / s3 青）：
#   第 1 帧 t=1 ：+X  +Z  -X  -Z
#   第 2 帧 t=11：+Z  -X  -Z  +X
#   第 3 帧 t=21：-X  -Z  +X  +Z
#   第 4 帧 t=31：-Z  +X  +Z  -X
# t=41 时驱动器把时钟归 1 并重下第 1 帧 ⇒ 与 t=1 间隔正好 40 刻，循环无缝。

# ---- 第 1 帧（t=1）----
execute if score #decor_example decor_t matches 1 run data merge entity @e[tag=decor_example_0,limit=1] {interpolation_duration:10, start_interpolation:0, transformation:{translation:[2.0f,0.0f,0.0f]}}
execute if score #decor_example decor_t matches 1 run data merge entity @e[tag=decor_example_1,limit=1] {interpolation_duration:10, start_interpolation:0, transformation:{translation:[0.0f,0.0f,2.0f]}}
execute if score #decor_example decor_t matches 1 run data merge entity @e[tag=decor_example_2,limit=1] {interpolation_duration:10, start_interpolation:0, transformation:{translation:[-2.0f,0.0f,0.0f]}}
execute if score #decor_example decor_t matches 1 run data merge entity @e[tag=decor_example_3,limit=1] {interpolation_duration:10, start_interpolation:0, transformation:{translation:[0.0f,0.0f,-2.0f]}}

# ---- 第 2 帧（t=11）----
execute if score #decor_example decor_t matches 11 run data merge entity @e[tag=decor_example_0,limit=1] {interpolation_duration:10, start_interpolation:0, transformation:{translation:[0.0f,0.0f,2.0f]}}
execute if score #decor_example decor_t matches 11 run data merge entity @e[tag=decor_example_1,limit=1] {interpolation_duration:10, start_interpolation:0, transformation:{translation:[-2.0f,0.0f,0.0f]}}
execute if score #decor_example decor_t matches 11 run data merge entity @e[tag=decor_example_2,limit=1] {interpolation_duration:10, start_interpolation:0, transformation:{translation:[0.0f,0.0f,-2.0f]}}
execute if score #decor_example decor_t matches 11 run data merge entity @e[tag=decor_example_3,limit=1] {interpolation_duration:10, start_interpolation:0, transformation:{translation:[2.0f,0.0f,0.0f]}}

# ---- 第 3 帧（t=21）----
execute if score #decor_example decor_t matches 21 run data merge entity @e[tag=decor_example_0,limit=1] {interpolation_duration:10, start_interpolation:0, transformation:{translation:[-2.0f,0.0f,0.0f]}}
execute if score #decor_example decor_t matches 21 run data merge entity @e[tag=decor_example_1,limit=1] {interpolation_duration:10, start_interpolation:0, transformation:{translation:[0.0f,0.0f,-2.0f]}}
execute if score #decor_example decor_t matches 21 run data merge entity @e[tag=decor_example_2,limit=1] {interpolation_duration:10, start_interpolation:0, transformation:{translation:[2.0f,0.0f,0.0f]}}
execute if score #decor_example decor_t matches 21 run data merge entity @e[tag=decor_example_3,limit=1] {interpolation_duration:10, start_interpolation:0, transformation:{translation:[0.0f,0.0f,2.0f]}}

# ---- 第 4 帧（t=31）----
execute if score #decor_example decor_t matches 31 run data merge entity @e[tag=decor_example_0,limit=1] {interpolation_duration:10, start_interpolation:0, transformation:{translation:[0.0f,0.0f,-2.0f]}}
execute if score #decor_example decor_t matches 31 run data merge entity @e[tag=decor_example_1,limit=1] {interpolation_duration:10, start_interpolation:0, transformation:{translation:[2.0f,0.0f,0.0f]}}
execute if score #decor_example decor_t matches 31 run data merge entity @e[tag=decor_example_2,limit=1] {interpolation_duration:10, start_interpolation:0, transformation:{translation:[0.0f,0.0f,2.0f]}}
execute if score #decor_example decor_t matches 31 run data merge entity @e[tag=decor_example_3,limit=1] {interpolation_duration:10, start_interpolation:0, transformation:{translation:[-2.0f,0.0f,0.0f]}}