# ========== title2448 驱动器（每刻自调度）==========
# 绝对时钟 #t2448_wave（本套专用）从 0 起每刻 +1，与开关当刻对齐（开关 schedule 1t、当刻标 0）
# 时间轴：#t2448_wave = 0 出生「攻」并起 0-8 段；8/10/12/14/16/18 出生六条边；24-28 六条边向外扩散回出生位；28 全部删除
# ★ 缓动 = 每刻下发一个关键帧（等价精确的三次方缓出）：display 每个关键帧只插值 1 刻（interpolation_duration:1）
#   不用展示实体动画系统：它每步会把「不参与动画的旋转」写成单位四元数（会把边/字的朝向抹掉）

# 绝对时钟推进
scoreboard players add #t2448_wave t2448_t 1

# ===== 「攻」：scale 4.5 → 3.0625，8 刻三次方缓出（每刻一帧）=====
# 只 merge 缩放，不动 translation / rotation ⇒ 朝向与位置保持出生时的值
execute if score #t2448_wave t2448_t matches 1 as @e[tag=t2448_gong] run data merge entity @s {interpolation_duration: 1, start_interpolation: 0, transformation: {scale: [4.0255127f, 4.0255127f, 4.0255127f]}}
execute if score #t2448_wave t2448_t matches 2 as @e[tag=t2448_gong] run data merge entity @s {interpolation_duration: 1, start_interpolation: 0, transformation: {scale: [3.6689453f, 3.6689453f, 3.6689453f]}}
execute if score #t2448_wave t2448_t matches 3 as @e[tag=t2448_gong] run data merge entity @s {interpolation_duration: 1, start_interpolation: 0, transformation: {scale: [3.4134521f, 3.4134521f, 3.4134521f]}}
execute if score #t2448_wave t2448_t matches 4 as @e[tag=t2448_gong] run data merge entity @s {interpolation_duration: 1, start_interpolation: 0, transformation: {scale: [3.2421875f, 3.2421875f, 3.2421875f]}}
execute if score #t2448_wave t2448_t matches 5 as @e[tag=t2448_gong] run data merge entity @s {interpolation_duration: 1, start_interpolation: 0, transformation: {scale: [3.1383057f, 3.1383057f, 3.1383057f]}}
execute if score #t2448_wave t2448_t matches 6 as @e[tag=t2448_gong] run data merge entity @s {interpolation_duration: 1, start_interpolation: 0, transformation: {scale: [3.0849609f, 3.0849609f, 3.0849609f]}}
execute if score #t2448_wave t2448_t matches 7 as @e[tag=t2448_gong] run data merge entity @s {interpolation_duration: 1, start_interpolation: 0, transformation: {scale: [3.0653076f, 3.0653076f, 3.0653076f]}}
execute if score #t2448_wave t2448_t matches 8 as @e[tag=t2448_gong] run data merge entity @s {interpolation_duration: 1, start_interpolation: 0, transformation: {scale: [3.0625f, 3.0625f, 3.0625f]}}

# ===== 六条边：每刻调用一次出生函数（函数内按各自固定时刻比对 #t2448_wave）=====
function rhythm_axe:maps/goodworld/title2448summon

# ===== 六条边：向内平移 1 格（各 6 刻三次方缓出，每刻一帧；只 merge 平移，旋转/缩放保持出生值）=====
# 边1（出生 8，就位 14）：+1.2000/-0.7211 → 目标 +0.3429/-0.2060
execute if score #t2448_wave t2448_t matches 9 as @e[tag=t2448_e1] run data merge entity @s {interpolation_duration: 1, start_interpolation: 0, transformation: {translation: [0.83891267f, -0.50406957f, 0.0f]}}
execute if score #t2448_wave t2448_t matches 10 as @e[tag=t2448_e1] run data merge entity @s {interpolation_duration: 1, start_interpolation: 0, transformation: {translation: [0.59684235f, -0.358619f, 0.0f]}}
execute if score #t2448_wave t2448_t matches 11 as @e[tag=t2448_e1] run data merge entity @s {interpolation_duration: 1, start_interpolation: 0, transformation: {translation: [0.45001277f, -0.27039492f, 0.0f]}}
execute if score #t2448_wave t2448_t matches 12 as @e[tag=t2448_e1] run data merge entity @s {interpolation_duration: 1, start_interpolation: 0, transformation: {translation: [0.3746138f, -0.22509065f, 0.0f]}}
execute if score #t2448_wave t2448_t matches 13 as @e[tag=t2448_e1] run data merge entity @s {interpolation_duration: 1, start_interpolation: 0, transformation: {translation: [0.34683523f, -0.20839961f, 0.0f]}}
execute if score #t2448_wave t2448_t matches 14 as @e[tag=t2448_e1] run data merge entity @s {interpolation_duration: 1, start_interpolation: 0, transformation: {translation: [0.34286687f, -0.20601518f, 0.0f]}}
# 边2（出生 10，就位 16）：+1.2124/+0.7000 → 目标 +0.3464/+0.2000
execute if score #t2448_wave t2448_t matches 11 as @e[tag=t2448_e2] run data merge entity @s {interpolation_duration: 1, start_interpolation: 0, transformation: {translation: [0.8475823f, 0.48935175f, 0.0f]}}
execute if score #t2448_wave t2448_t matches 12 as @e[tag=t2448_e2] run data merge entity @s {interpolation_duration: 1, start_interpolation: 0, transformation: {translation: [0.6030103f, 0.34814808f, 0.0f]}}
execute if score #t2448_wave t2448_t matches 13 as @e[tag=t2448_e2] run data merge entity @s {interpolation_duration: 1, start_interpolation: 0, transformation: {translation: [0.45466334f, 0.26249996f, 0.0f]}}
execute if score #t2448_wave t2448_t matches 14 as @e[tag=t2448_e2] run data merge entity @s {interpolation_duration: 1, start_interpolation: 0, transformation: {translation: [0.37848517f, 0.2185185f, 0.0f]}}
execute if score #t2448_wave t2448_t matches 15 as @e[tag=t2448_e2] run data merge entity @s {interpolation_duration: 1, start_interpolation: 0, transformation: {translation: [0.35041955f, 0.20231478f, 0.0f]}}
execute if score #t2448_wave t2448_t matches 16 as @e[tag=t2448_e2] run data merge entity @s {interpolation_duration: 1, start_interpolation: 0, transformation: {translation: [0.34641016f, 0.19999996f, 0.0f]}}
# 边3（出生 12，就位 18）：+0.0244/+1.3998 → 目标 +0.0070/+0.3999
execute if score #t2448_wave t2448_t matches 13 as @e[tag=t2448_e3] run data merge entity @s {interpolation_duration: 1, start_interpolation: 0, transformation: {translation: [0.017080735f, 0.9785546f, 0.0f]}}
execute if score #t2448_wave t2448_t matches 14 as @e[tag=t2448_e3] run data merge entity @s {interpolation_duration: 1, start_interpolation: 0, transformation: {translation: [0.012152047f, 0.69619024f, 0.0f]}}
execute if score #t2448_wave t2448_t matches 15 as @e[tag=t2448_e3] run data merge entity @s {interpolation_duration: 1, start_interpolation: 0, transformation: {translation: [0.0091625135f, 0.52491999f, 0.0f]}}
execute if score #t2448_wave t2448_t matches 16 as @e[tag=t2448_e3] run data merge entity @s {interpolation_duration: 1, start_interpolation: 0, transformation: {translation: [0.0076273484f, 0.43697044f, 0.0f]}}
execute if score #t2448_wave t2448_t matches 17 as @e[tag=t2448_e3] run data merge entity @s {interpolation_duration: 1, start_interpolation: 0, transformation: {translation: [0.0070617613f, 0.40456799f, 0.0f]}}
execute if score #t2448_wave t2448_t matches 18 as @e[tag=t2448_e3] run data merge entity @s {interpolation_duration: 1, start_interpolation: 0, transformation: {translation: [0.006980963f, 0.39993906f, 0.0f]}}
# 边4（出生 14，就位 20）：0.0000/-1.4000 → 目标 0.0000/-0.4000
execute if score #t2448_wave t2448_t matches 15 as @e[tag=t2448_e4] run data merge entity @s {interpolation_duration: 1, start_interpolation: 0, transformation: {translation: [2.5008974E-6f, -0.97870368f, 0.0f]}}
execute if score #t2448_wave t2448_t matches 16 as @e[tag=t2448_e4] run data merge entity @s {interpolation_duration: 1, start_interpolation: 0, transformation: {translation: [1.7792572E-6f, -0.6962963f, 0.0f]}}
execute if score #t2448_wave t2448_t matches 17 as @e[tag=t2448_e4] run data merge entity @s {interpolation_duration: 1, start_interpolation: 0, transformation: {translation: [1.3415411E-6f, -0.525f, 0.0f]}}
execute if score #t2448_wave t2448_t matches 18 as @e[tag=t2448_e4] run data merge entity @s {interpolation_duration: 1, start_interpolation: 0, transformation: {translation: [1.1167679E-6f, -0.43703705f, 0.0f]}}
execute if score #t2448_wave t2448_t matches 19 as @e[tag=t2448_e4] run data merge entity @s {interpolation_duration: 1, start_interpolation: 0, transformation: {translation: [1.0339567E-6f, -0.40462962f, 0.0f]}}
execute if score #t2448_wave t2448_t matches 20 as @e[tag=t2448_e4] run data merge entity @s {interpolation_duration: 1, start_interpolation: 0, transformation: {translation: [1.0221265E-6f, -0.4f, 0.0f]}}
# 边5（出生 16，就位 22）：-1.2000/+0.7211 → 目标 -0.3429/+0.2060
execute if score #t2448_wave t2448_t matches 17 as @e[tag=t2448_e5] run data merge entity @s {interpolation_duration: 1, start_interpolation: 0, transformation: {translation: [-0.83891284f, 0.50406969f, 0.0f]}}
execute if score #t2448_wave t2448_t matches 18 as @e[tag=t2448_e5] run data merge entity @s {interpolation_duration: 1, start_interpolation: 0, transformation: {translation: [-0.5968424f, 0.3586191f, 0.0f]}}
execute if score #t2448_wave t2448_t matches 19 as @e[tag=t2448_e5] run data merge entity @s {interpolation_duration: 1, start_interpolation: 0, transformation: {translation: [-0.45001283f, 0.27039498f, 0.0f]}}
execute if score #t2448_wave t2448_t matches 20 as @e[tag=t2448_e5] run data merge entity @s {interpolation_duration: 1, start_interpolation: 0, transformation: {translation: [-0.37461388f, 0.22509071f, 0.0f]}}
execute if score #t2448_wave t2448_t matches 21 as @e[tag=t2448_e5] run data merge entity @s {interpolation_duration: 1, start_interpolation: 0, transformation: {translation: [-0.34683529f, 0.20839967f, 0.0f]}}
execute if score #t2448_wave t2448_t matches 22 as @e[tag=t2448_e5] run data merge entity @s {interpolation_duration: 1, start_interpolation: 0, transformation: {translation: [-0.34286693f, 0.20601523f, 0.0f]}}
# 边6（出生 18，就位 24）：-1.2245/-0.6787 → 目标 -0.3498/-0.1939
execute if score #t2448_wave t2448_t matches 19 as @e[tag=t2448_e6] run data merge entity @s {interpolation_duration: 1, start_interpolation: 0, transformation: {translation: [-0.85599345f, -0.4744851f, 0.0f]}}
execute if score #t2448_wave t2448_t matches 20 as @e[tag=t2448_e6] run data merge entity @s {interpolation_duration: 1, start_interpolation: 0, transformation: {translation: [-0.60899442f, -0.33757123f, 0.0f]}}
execute if score #t2448_wave t2448_t matches 21 as @e[tag=t2448_e6] run data merge entity @s {interpolation_duration: 1, start_interpolation: 0, transformation: {translation: [-0.4591753f, -0.25452513f, 0.0f]}}
execute if score #t2448_wave t2448_t matches 22 as @e[tag=t2448_e6] run data merge entity @s {interpolation_duration: 1, start_interpolation: 0, transformation: {translation: [-0.38224116f, -0.21187982f, 0.0f]}}
execute if score #t2448_wave t2448_t matches 23 as @e[tag=t2448_e6] run data merge entity @s {interpolation_duration: 1, start_interpolation: 0, transformation: {translation: [-0.353897f, -0.19616839f, 0.0f]}}
execute if score #t2448_wave t2448_t matches 24 as @e[tag=t2448_e6] run data merge entity @s {interpolation_duration: 1, start_interpolation: 0, transformation: {translation: [-0.34984785f, -0.1939239f, 0.0f]}}

# ===== 六条边：24→28 同时向外扩散 1 格（回到出生位 = 目标 ×3.5），4 刻三次方缓入 =====
# 帧下发在 24-27（每帧 1 刻插值）⇒ 第 28 刻正好到位，随即被删除（最后一帧不会演）
# e1
execute if score #t2448_wave t2448_t matches 24 as @e[tag=t2448_e1] run data merge entity @s {interpolation_duration: 1, start_interpolation: 0, transformation: {translation: [0.35626012f, -0.21406265f, 0.0f]}}
execute if score #t2448_wave t2448_t matches 25 as @e[tag=t2448_e1] run data merge entity @s {interpolation_duration: 1, start_interpolation: 0, transformation: {translation: [0.45001277f, -0.27039492f, 0.0f]}}
execute if score #t2448_wave t2448_t matches 26 as @e[tag=t2448_e1] run data merge entity @s {interpolation_duration: 1, start_interpolation: 0, transformation: {translation: [0.70448428f, -0.42329681f, 0.0f]}}
execute if score #t2448_wave t2448_t matches 27 as @e[tag=t2448_e1] run data merge entity @s {interpolation_duration: 1, start_interpolation: 0, transformation: {translation: [1.200034f, -0.72105312f, 0.0f]}}
# e2
execute if score #t2448_wave t2448_t matches 24 as @e[tag=t2448_e2] run data merge entity @s {interpolation_duration: 1, start_interpolation: 0, transformation: {translation: [0.35994181f, 0.20781246f, 0.0f]}}
execute if score #t2448_wave t2448_t matches 25 as @e[tag=t2448_e2] run data merge entity @s {interpolation_duration: 1, start_interpolation: 0, transformation: {translation: [0.45466334f, 0.2625f, 0.0f]}}
execute if score #t2448_wave t2448_t matches 26 as @e[tag=t2448_e2] run data merge entity @s {interpolation_duration: 1, start_interpolation: 0, transformation: {translation: [0.71176463f, 0.41093743f, 0.0f]}}
execute if score #t2448_wave t2448_t matches 27 as @e[tag=t2448_e2] run data merge entity @s {interpolation_duration: 1, start_interpolation: 0, transformation: {translation: [1.2124356f, 0.69999987f, 0.0f]}}
# e3
execute if score #t2448_wave t2448_t matches 24 as @e[tag=t2448_e3] run data merge entity @s {interpolation_duration: 1, start_interpolation: 0, transformation: {translation: [0.00725366f, 0.41556168f, 0.0f]}}
execute if score #t2448_wave t2448_t matches 25 as @e[tag=t2448_e3] run data merge entity @s {interpolation_duration: 1, start_interpolation: 0, transformation: {translation: [0.00916251f, 0.52492f, 0.0f]}}
execute if score #t2448_wave t2448_t matches 26 as @e[tag=t2448_e3] run data merge entity @s {interpolation_duration: 1, start_interpolation: 0, transformation: {translation: [0.0143437f, 0.8217498f, 0.0f]}}
execute if score #t2448_wave t2448_t matches 27 as @e[tag=t2448_e3] run data merge entity @s {interpolation_duration: 1, start_interpolation: 0, transformation: {translation: [0.02443337f, 1.39978671f, 0.0f]}}
# e4
execute if score #t2448_wave t2448_t matches 24 as @e[tag=t2448_e4] run data merge entity @s {interpolation_duration: 1, start_interpolation: 0, transformation: {translation: [1.0620533E-6f, -0.41562501f, 0.0f]}}
execute if score #t2448_wave t2448_t matches 25 as @e[tag=t2448_e4] run data merge entity @s {interpolation_duration: 1, start_interpolation: 0, transformation: {translation: [1.3415411E-6f, -0.525f, 0.0f]}}
execute if score #t2448_wave t2448_t matches 26 as @e[tag=t2448_e4] run data merge entity @s {interpolation_duration: 1, start_interpolation: 0, transformation: {translation: [2.1001506E-6f, -0.82187498f, 0.0f]}}
execute if score #t2448_wave t2448_t matches 27 as @e[tag=t2448_e4] run data merge entity @s {interpolation_duration: 1, start_interpolation: 0, transformation: {translation: [3.5774428E-6f, -1.4f, 0.0f]}}
# e5
execute if score #t2448_wave t2448_t matches 24 as @e[tag=t2448_e5] run data merge entity @s {interpolation_duration: 1, start_interpolation: 0, transformation: {translation: [-0.35626018f, 0.21406271f, 0.0f]}}
execute if score #t2448_wave t2448_t matches 25 as @e[tag=t2448_e5] run data merge entity @s {interpolation_duration: 1, start_interpolation: 0, transformation: {translation: [-0.45001283f, 0.27039498f, 0.0f]}}
execute if score #t2448_wave t2448_t matches 26 as @e[tag=t2448_e5] run data merge entity @s {interpolation_duration: 1, start_interpolation: 0, transformation: {translation: [-0.7044844f, 0.42329693f, 0.0f]}}
execute if score #t2448_wave t2448_t matches 27 as @e[tag=t2448_e5] run data merge entity @s {interpolation_duration: 1, start_interpolation: 0, transformation: {translation: [-1.20003426f, 0.7210533f, 0.0f]}}
# e6
execute if score #t2448_wave t2448_t matches 24 as @e[tag=t2448_e6] run data merge entity @s {interpolation_duration: 1, start_interpolation: 0, transformation: {translation: [-0.36351377f, -0.20149904f, 0.0f]}}
execute if score #t2448_wave t2448_t matches 25 as @e[tag=t2448_e6] run data merge entity @s {interpolation_duration: 1, start_interpolation: 0, transformation: {translation: [-0.4591753f, -0.25452513f, 0.0f]}}
execute if score #t2448_wave t2448_t matches 26 as @e[tag=t2448_e6] run data merge entity @s {interpolation_duration: 1, start_interpolation: 0, transformation: {translation: [-0.718828f, -0.39845303f, 0.0f]}}
execute if score #t2448_wave t2448_t matches 27 as @e[tag=t2448_e6] run data merge entity @s {interpolation_duration: 1, start_interpolation: 0, transformation: {translation: [-1.22446752f, -0.67873365f, 0.0f]}}

# ===== 第 28 刻：全部删除（先清计时再 kill，避免残留计分项）=====
execute if score #t2448_wave t2448_t matches 28.. run tag @e[tag=t2448] add t2448_done
execute as @e[tag=t2448_done] run scoreboard players reset @s t2448_t
kill @e[tag=t2448_done]

# ===== 继续条件：绝对时钟 ≤ 29（保证 28.. 的删除已执行）→ 再排一刻；否则停链并删计分项 =====
#（只 schedule 一次，不能分两条写，否则同一刻会排出两条计时链）
execute if score #t2448_wave t2448_t matches ..29 run schedule function rhythm_axe:maps/goodworld/title2448_tick 1t
execute if score #t2448_wave t2448_t matches 30.. run scoreboard objectives remove t2448_t