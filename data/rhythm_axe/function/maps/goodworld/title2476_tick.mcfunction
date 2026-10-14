# ========== title2476 驱动器（每刻自调度）==========
# 绝对时钟 #t2476_wave：出生当刻记 0，本驱动器每刻 +1（开关 schedule 1t 后从第 1 刻起调）
# 时间轴（出生=0）：2 隐藏 / 4 显示 / 6 隐藏 / 8 显示 / 9 起缩小 / 36 到位并删除
# ★ 隐藏=scale 0、显示=scale 4.5（平移恒 -1.08），都用 interpolation_duration:0 瞬切
# ★ 缩小：第 8 刻先瞬切显形到 scale 4.5，第 9 刻起 interpolation_duration:27 缩到 scale 2.5 / 平移 -0.6
#   （原生线性，正好第 36 刻到位）
#   —— 不能把「显形」和「缩小」放同一刻：display 同刻多次 merge 只算一次变更，
#      缩小会从隐藏态 scale=0 起算 → 变成「从 0 长大」而非「先显形再缩小」（title2448 已踩）

# 绝对时钟推进
scoreboard players add #t2476_wave t2476_t 1

# 闪烁：2 隐藏、4 显示、6 隐藏、8 显示（均瞬切）
execute if score #t2476_wave t2476_t matches 2 as @e[tag=t2476] run data merge entity @s {interpolation_duration: 0, start_interpolation: 0, transformation: {left_rotation: [0.0f, 1.0f, 0.0f, 0.0f], right_rotation: [0.0f, 0.0f, 0.0f, 1.0f], scale: [0.0f, 0.0f, 0.0f], translation: [0.0f, -1.08f, 0.0f]}}
execute if score #t2476_wave t2476_t matches 4 as @e[tag=t2476] run data merge entity @s {interpolation_duration: 0, start_interpolation: 0, transformation: {left_rotation: [0.0f, 1.0f, 0.0f, 0.0f], right_rotation: [0.0f, 0.0f, 0.0f, 1.0f], scale: [4.5f, 4.5f, 4.5f], translation: [0.0f, -1.08f, 0.0f]}}
execute if score #t2476_wave t2476_t matches 6 as @e[tag=t2476] run data merge entity @s {interpolation_duration: 0, start_interpolation: 0, transformation: {left_rotation: [0.0f, 1.0f, 0.0f, 0.0f], right_rotation: [0.0f, 0.0f, 0.0f, 1.0f], scale: [0.0f, 0.0f, 0.0f], translation: [0.0f, -1.08f, 0.0f]}}
execute if score #t2476_wave t2476_t matches 8 as @e[tag=t2476] run data merge entity @s {interpolation_duration: 0, start_interpolation: 0, transformation: {left_rotation: [0.0f, 1.0f, 0.0f, 0.0f], right_rotation: [0.0f, 0.0f, 0.0f, 1.0f], scale: [4.5f, 4.5f, 4.5f], translation: [0.0f, -1.08f, 0.0f]}}

# 缩小：第 9 刻起，27 刻线性缩到 2.5、平移到 -0.6（第 36 刻到位）
execute if score #t2476_wave t2476_t matches 9 as @e[tag=t2476] run data merge entity @s {interpolation_duration: 27, start_interpolation: 0, transformation: {left_rotation: [0.0f, 1.0f, 0.0f, 0.0f], right_rotation: [0.0f, 0.0f, 0.0f, 1.0f], scale: [2.5f, 2.5f, 2.5f], translation: [0.0f, -0.6f, 0.0f]}}

# ===== 第 36 刻：全部删除（先清计时再 kill，避免残留计分项）=====
execute if score #t2476_wave t2476_t matches 36.. run tag @e[tag=t2476] add t2476_done
execute as @e[tag=t2476_done] run scoreboard players reset @s t2476_t
kill @e[tag=t2476_done]

# ===== 继续条件：绝对时钟 ≤ 37（保证 36.. 的删除已执行）→ 再排一刻；否则停链并删计分项 =====
#（只 schedule 一次，不能分两条写，否则同一刻会排出两条计时链）
execute if score #t2476_wave t2476_t matches ..37 run schedule function rhythm_axe:maps/goodworld/title2476_tick 1t
execute if score #t2476_wave t2476_t matches 38.. run scoreboard objectives remove t2476_t