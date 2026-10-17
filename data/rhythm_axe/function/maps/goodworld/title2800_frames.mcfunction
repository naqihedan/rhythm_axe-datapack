# ========== title2800 逐刻关键帧（入口与驱动器都调用本函数）==========
# 时钟 #t2800_wave t2800_t → 出生当刻 = 1
#
# ★★ 合并规则（2026-10-17 踩坑后定下）：**只写「这一刻真的变了」的东西**
#   1) 每个实体只有**它入场的第一帧**写 scale（从出生时的 0 显形成满态）；其余只写 translation。
#   2) 未在动的实体**一个字节都别碰**：每次 data merge 都会让客户端重启插值
#      （interpolation_duration: 1），对静止实体反复 merge 就是「抽搐」。
#   3) 退场段虽然写成「对所有实体」，但那一刻它们**确实都在动**（各自回到自己的起始偏移）；
#      **第 28 刻不写**（那刻值仍是 0，写了就是对静止实体的无效 merge）。
#
# 时间轴（刻 · 出生 = 1）：
#   1-5    G2     从 y+2 落到位（translation = 0）
#   5-9    R2     同上
#   9-13   018    同上
#   12-16  CLIMAX 从 y-2 升到位
#   16-20  左斜线  从 y+2 落到位
#   24-28  右斜线  从 y-2 升到位
#   28-29  全体静止一刻（20-24 与 28-29 都是零 merge）
#   29-32  退场：6 个实体各自回到**出生/summon 时的偏移**（y 又变回 ±2，方向与来时相反）
#           ★ 第 32 刻的值必须等于 summon 时的值 —— 因为第 32 刻就 kill，最后一帧演不到
#   32     全部删除
#
# ★ 只写 scale + translation，**不碰 left_rotation** ⇒ 斜线倾角不会被抹掉

# ---- G2（t2800_g2）：t=1 起 4 刻，落下（第一帧显形，之后只动位置）----
execute if score #t2800_wave t2800_t matches 1 as @e[tag=t2800_g2] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {scale: [3.0f, 2.5f, 1.0f], translation: [0.0f, 2.0f, 0.0f]}}
execute if score #t2800_wave t2800_t matches 2 as @e[tag=t2800_g2] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.0f, 1.9375f, 0.0f]}}
execute if score #t2800_wave t2800_t matches 3 as @e[tag=t2800_g2] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.0f, 1.0f, 0.0f]}}
execute if score #t2800_wave t2800_t matches 4 as @e[tag=t2800_g2] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.0f, 0.0625f, 0.0f]}}
execute if score #t2800_wave t2800_t matches 5 as @e[tag=t2800_g2] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.0f, 0.0f, 0.0f]}}

# ---- R2（t2800_r2）：t=5 起 4 刻，落下（第一帧显形，之后只动位置）----
execute if score #t2800_wave t2800_t matches 5 as @e[tag=t2800_r2] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {scale: [3.0f, 2.5f, 1.0f], translation: [0.0f, 2.0f, 0.0f]}}
execute if score #t2800_wave t2800_t matches 6 as @e[tag=t2800_r2] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.0f, 1.9375f, 0.0f]}}
execute if score #t2800_wave t2800_t matches 7 as @e[tag=t2800_r2] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.0f, 1.0f, 0.0f]}}
execute if score #t2800_wave t2800_t matches 8 as @e[tag=t2800_r2] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.0f, 0.0625f, 0.0f]}}
execute if score #t2800_wave t2800_t matches 9 as @e[tag=t2800_r2] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.0f, 0.0f, 0.0f]}}

# ---- 018（t2800_018）：t=9 起 4 刻，落下（第一帧显形，之后只动位置）----
execute if score #t2800_wave t2800_t matches 9 as @e[tag=t2800_018] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {scale: [3.0f, 2.5f, 1.0f], translation: [0.0f, 2.0f, 0.0f]}}
execute if score #t2800_wave t2800_t matches 10 as @e[tag=t2800_018] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.0f, 1.9375f, 0.0f]}}
execute if score #t2800_wave t2800_t matches 11 as @e[tag=t2800_018] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.0f, 1.0f, 0.0f]}}
execute if score #t2800_wave t2800_t matches 12 as @e[tag=t2800_018] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.0f, 0.0625f, 0.0f]}}
execute if score #t2800_wave t2800_t matches 13 as @e[tag=t2800_018] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.0f, 0.0f, 0.0f]}}

# ---- CLIMAX（t2800_climax）：t=12 起 4 刻，上升（第一帧显形，之后只动位置）----
execute if score #t2800_wave t2800_t matches 12 as @e[tag=t2800_climax] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {scale: [1.5125f, 1.2f, 1.0f], translation: [0.0f, -2.0f, 0.0f]}}
execute if score #t2800_wave t2800_t matches 13 as @e[tag=t2800_climax] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.0f, -1.9375f, 0.0f]}}
execute if score #t2800_wave t2800_t matches 14 as @e[tag=t2800_climax] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.0f, -1.0f, 0.0f]}}
execute if score #t2800_wave t2800_t matches 15 as @e[tag=t2800_climax] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.0f, -0.0625f, 0.0f]}}
execute if score #t2800_wave t2800_t matches 16 as @e[tag=t2800_climax] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.0f, 0.0f, 0.0f]}}

# ---- 左斜线（t2800_slashL）：t=16 起 4 刻，落下（第一帧显形，之后只动位置）----
execute if score #t2800_wave t2800_t matches 16 as @e[tag=t2800_slashL] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {scale: [0.625f, 3.75f, 1.0f], translation: [0.0f, 2.0f, 0.0f]}}
execute if score #t2800_wave t2800_t matches 17 as @e[tag=t2800_slashL] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.0f, 1.9375f, 0.0f]}}
execute if score #t2800_wave t2800_t matches 18 as @e[tag=t2800_slashL] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.0f, 1.0f, 0.0f]}}
execute if score #t2800_wave t2800_t matches 19 as @e[tag=t2800_slashL] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.0f, 0.0625f, 0.0f]}}
execute if score #t2800_wave t2800_t matches 20 as @e[tag=t2800_slashL] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.0f, 0.0f, 0.0f]}}

# ---- 右斜线（t2800_slashR）：t=24 起 4 刻，上升（第一帧显形，之后只动位置）----
execute if score #t2800_wave t2800_t matches 24 as @e[tag=t2800_slashR] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {scale: [0.625f, 3.75f, 1.0f], translation: [0.0f, -2.0f, 0.0f]}}
execute if score #t2800_wave t2800_t matches 25 as @e[tag=t2800_slashR] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.0f, -1.9375f, 0.0f]}}
execute if score #t2800_wave t2800_t matches 26 as @e[tag=t2800_slashR] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.0f, -1.0f, 0.0f]}}
execute if score #t2800_wave t2800_t matches 27 as @e[tag=t2800_slashR] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.0f, -0.0625f, 0.0f]}}
execute if score #t2800_wave t2800_t matches 28 as @e[tag=t2800_slashR] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.0f, 0.0f, 0.0f]}}

# ---- 29-32 退场：各自回到 summon 时的偏移（y：0 → ±2）----
#   与入场同一条四次缓入缓出曲线、方向相反（来时起点 = 去时终点）
#   28 刻不写（值仍是 0，属无效 merge）；**32 刻必须已到 ±2**，否则最后一帧演不到
execute if score #t2800_wave t2800_t matches 29 as @e[tag=t2800_g2] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.0f, 0.0625f, 0.0f]}}
execute if score #t2800_wave t2800_t matches 29 as @e[tag=t2800_r2] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.0f, 0.0625f, 0.0f]}}
execute if score #t2800_wave t2800_t matches 29 as @e[tag=t2800_018] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.0f, 0.0625f, 0.0f]}}
execute if score #t2800_wave t2800_t matches 29 as @e[tag=t2800_climax] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.0f, -0.0625f, 0.0f]}}
execute if score #t2800_wave t2800_t matches 29 as @e[tag=t2800_slashL] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.0f, 0.0625f, 0.0f]}}
execute if score #t2800_wave t2800_t matches 29 as @e[tag=t2800_slashR] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.0f, -0.0625f, 0.0f]}}
execute if score #t2800_wave t2800_t matches 30 as @e[tag=t2800_g2] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.0f, 1.0f, 0.0f]}}
execute if score #t2800_wave t2800_t matches 30 as @e[tag=t2800_r2] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.0f, 1.0f, 0.0f]}}
execute if score #t2800_wave t2800_t matches 30 as @e[tag=t2800_018] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.0f, 1.0f, 0.0f]}}
execute if score #t2800_wave t2800_t matches 30 as @e[tag=t2800_climax] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.0f, -1.0f, 0.0f]}}
execute if score #t2800_wave t2800_t matches 30 as @e[tag=t2800_slashL] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.0f, 1.0f, 0.0f]}}
execute if score #t2800_wave t2800_t matches 30 as @e[tag=t2800_slashR] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.0f, -1.0f, 0.0f]}}
execute if score #t2800_wave t2800_t matches 31 as @e[tag=t2800_g2] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.0f, 1.9375f, 0.0f]}}
execute if score #t2800_wave t2800_t matches 31 as @e[tag=t2800_r2] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.0f, 1.9375f, 0.0f]}}
execute if score #t2800_wave t2800_t matches 31 as @e[tag=t2800_018] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.0f, 1.9375f, 0.0f]}}
execute if score #t2800_wave t2800_t matches 31 as @e[tag=t2800_climax] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.0f, -1.9375f, 0.0f]}}
execute if score #t2800_wave t2800_t matches 31 as @e[tag=t2800_slashL] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.0f, 1.9375f, 0.0f]}}
execute if score #t2800_wave t2800_t matches 31 as @e[tag=t2800_slashR] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.0f, -1.9375f, 0.0f]}}
execute if score #t2800_wave t2800_t matches 32 as @e[tag=t2800_g2] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.0f, 2.0f, 0.0f]}}
execute if score #t2800_wave t2800_t matches 32 as @e[tag=t2800_r2] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.0f, 2.0f, 0.0f]}}
execute if score #t2800_wave t2800_t matches 32 as @e[tag=t2800_018] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.0f, 2.0f, 0.0f]}}
execute if score #t2800_wave t2800_t matches 32 as @e[tag=t2800_climax] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.0f, -2.0f, 0.0f]}}
execute if score #t2800_wave t2800_t matches 32 as @e[tag=t2800_slashL] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.0f, 2.0f, 0.0f]}}
execute if score #t2800_wave t2800_t matches 32 as @e[tag=t2800_slashR] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.0f, -2.0f, 0.0f]}}

