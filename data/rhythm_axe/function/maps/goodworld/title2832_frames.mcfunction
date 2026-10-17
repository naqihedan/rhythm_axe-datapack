# ========== title2832 关键帧（入口与驱动器都调用本函数）==========
# 时钟 #t2832_wave t2832_t → 出生当刻 = 0，驱动器第一刻 = 1
#
# ★★ 缓动实现 = 逐刻关键帧 + interpolation_duration:1（方案 B）
#    「段首单帧 + duration=段长」（方案 A）**只能线性**，做不出三次缓入缓出，
#    所以这里在 52~60 刻**每刻下发一帧「该刻的精确值」**，客户端在每两刻之间补 1 刻插值。
#    ⚠️ 不是「每刻一帧就抽搐」——抽搐的真因是**对同一个实体重复 merge**。
#      本段 4 个实体在 52~60 刻**确实都在动**，所以每刻都写是对的；静止期（1~51）零 merge。
# ★ 只写 translation —— 绝不写 left_rotation / scale（那是构图的一部分，写了会毁掉）
# ★ 第 1~51 刻：本函数一条都不匹配 ⇒ 零 merge、完全静止
#
# ★★ 为什么要逐个写乘客、而不是只写父实体（2026-10-17 查证）：
#   **乘客不继承父实体的 transformation**。三条独立证据：
#     ① 父实体 scale.y = 6.6875；若继承，「終」（scale 4）会变成 26.75 倍字号、飘到 y≈4.7 —— 荒谬
#     ② letter2768 段4「信封上移 0.2」：父 +0.2、各乘客也 +0.2 ⇒ 只有「不继承」视觉才正好 0.2
#     ③ 「終」绝对高度 = 父 0.5 + 乘客 0.625 = 1.125，与 title2800 / title_youwin 的标题高度一致
#   ⇒ 父实体只是**不可见的空容器**（background 透明 + text_opacity 0），它的 transformation 无视觉作用。
#   ⚠️ 想改组合位移就必须逐个写 3 个乘客；只动父实体 = 屏幕上什么都不会发生。
#
# 时间轴（刻 · 出生 = 0）：
#   52-60  整组（父实体 + 3 个乘客）translation.y 各 -2：全部文字下移 2 格
#          ★ 缓动 = **三次缓入缓出**：位移 = -2 × ease(u)，u = (刻-52)/8
#            ease(u) = u < 0.5 ? 4u³ : 1-4(1-u)³
#          两半严格对称：起步慢 → 中段（u=0.5 附近）最快 → 收尾慢
#   60     到位 → 驱动器 kill 全部（最后一帧演不到；想看到落位把驱动器收尾刻改成 61）
#
# ★ 2026-10-17：整条时间轴后移 32 刻（原本 20-28）——「没动画的空挡」加长 32 刻

# ---- 第 52~60 刻：整组下移 2 格（三次缓入缓出，逐刻一帧）----
#   ★ 每行 = 「该刻 · 该实体」的 translation；三个分量必须写全（translation 是**整组替换**）
#   ★ x / z 全程保持出生值不变，只有 y 在动 ⇒ 纯竖直下落（世界 -Y = 屏幕向下）
#   ★ 4 个实体（3 乘客 + 父实体）每刻都在动 ⇒ 每刻 4 行都要写
#   ★ 父实体（t2832_root）也要写：它的 background 是 50% 黑、**不透明** ⇒ 是块可见的黑色底板
#     （透明度只作用于文字，不作用于底板）→ 不写它就会出现「文字掉了、黑板留在原地」
#
#   k = 刻 - 52 ｜ u = k/8 ｜ ease(u) ：k=0 →0 ｜ 1 →0.0078125 ｜ 2 →0.0625 ｜ 3 →0.2109375
#                                   4 →0.5（位移正好一半）｜ 5 →0.7890625 ｜ 6 →0.9375
#                                   7 →0.9921875 ｜ 8 →1（注意中段快、两端慢）

# ---- 第 52 刻（k=0，起点：与出生值相同，作为插值锚点）----
execute if score #t2832_wave t2832_t matches 52 as @e[tag=t2832_name] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.0625f, 0.1875f, -0.1875f]}}
execute if score #t2832_wave t2832_t matches 52 as @e[tag=t2832_glyph] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.0f, 0.625f, -0.1875f]}}
execute if score #t2832_wave t2832_t matches 52 as @e[tag=t2832_bar] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.0f, 0.5625f, -0.1875f]}}
execute if score #t2832_wave t2832_t matches 52 as @e[tag=t2832_root] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.0f, 0.0f, 0.0f]}}

# ---- 第 53 刻（k=1，ease 0.0078125，位移 -0.015625）----
execute if score #t2832_wave t2832_t matches 53 as @e[tag=t2832_name] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.0625f, 0.171875f, -0.1875f]}}
execute if score #t2832_wave t2832_t matches 53 as @e[tag=t2832_glyph] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.0f, 0.609375f, -0.1875f]}}
execute if score #t2832_wave t2832_t matches 53 as @e[tag=t2832_bar] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.0f, 0.546875f, -0.1875f]}}
execute if score #t2832_wave t2832_t matches 53 as @e[tag=t2832_root] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.0f, -0.015625f, 0.0f]}}

# ---- 第 54 刻（k=2，ease 0.0625，位移 -0.125）----
execute if score #t2832_wave t2832_t matches 54 as @e[tag=t2832_name] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.0625f, 0.0625f, -0.1875f]}}
execute if score #t2832_wave t2832_t matches 54 as @e[tag=t2832_glyph] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.0f, 0.5f, -0.1875f]}}
execute if score #t2832_wave t2832_t matches 54 as @e[tag=t2832_bar] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.0f, 0.4375f, -0.1875f]}}
execute if score #t2832_wave t2832_t matches 54 as @e[tag=t2832_root] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.0f, -0.125f, 0.0f]}}

# ---- 第 55 刻（k=3，ease 0.2109375，位移 -0.421875）----
execute if score #t2832_wave t2832_t matches 55 as @e[tag=t2832_name] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.0625f, -0.234375f, -0.1875f]}}
execute if score #t2832_wave t2832_t matches 55 as @e[tag=t2832_glyph] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.0f, 0.203125f, -0.1875f]}}
execute if score #t2832_wave t2832_t matches 55 as @e[tag=t2832_bar] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.0f, 0.140625f, -0.1875f]}}
execute if score #t2832_wave t2832_t matches 55 as @e[tag=t2832_root] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.0f, -0.421875f, 0.0f]}}

# ---- 第 56 刻（k=4，ease 0.5，位移 -1.0 = 正好一半，此处速度最快）----
execute if score #t2832_wave t2832_t matches 56 as @e[tag=t2832_name] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.0625f, -0.8125f, -0.1875f]}}
execute if score #t2832_wave t2832_t matches 56 as @e[tag=t2832_glyph] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.0f, -0.375f, -0.1875f]}}
execute if score #t2832_wave t2832_t matches 56 as @e[tag=t2832_bar] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.0f, -0.4375f, -0.1875f]}}
execute if score #t2832_wave t2832_t matches 56 as @e[tag=t2832_root] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.0f, -1.0f, 0.0f]}}

# ---- 第 57 刻（k=5，ease 0.7890625，位移 -1.578125）----
execute if score #t2832_wave t2832_t matches 57 as @e[tag=t2832_name] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.0625f, -1.390625f, -0.1875f]}}
execute if score #t2832_wave t2832_t matches 57 as @e[tag=t2832_glyph] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.0f, -0.953125f, -0.1875f]}}
execute if score #t2832_wave t2832_t matches 57 as @e[tag=t2832_bar] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.0f, -1.015625f, -0.1875f]}}
execute if score #t2832_wave t2832_t matches 57 as @e[tag=t2832_root] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.0f, -1.578125f, 0.0f]}}

# ---- 第 58 刻（k=6，ease 0.9375，位移 -1.875）----
execute if score #t2832_wave t2832_t matches 58 as @e[tag=t2832_name] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.0625f, -1.6875f, -0.1875f]}}
execute if score #t2832_wave t2832_t matches 58 as @e[tag=t2832_glyph] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.0f, -1.25f, -0.1875f]}}
execute if score #t2832_wave t2832_t matches 58 as @e[tag=t2832_bar] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.0f, -1.3125f, -0.1875f]}}
execute if score #t2832_wave t2832_t matches 58 as @e[tag=t2832_root] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.0f, -1.875f, 0.0f]}}

# ---- 第 59 刻（k=7，ease 0.9921875，位移 -1.984375）----
execute if score #t2832_wave t2832_t matches 59 as @e[tag=t2832_name] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.0625f, -1.796875f, -0.1875f]}}
execute if score #t2832_wave t2832_t matches 59 as @e[tag=t2832_glyph] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.0f, -1.359375f, -0.1875f]}}
execute if score #t2832_wave t2832_t matches 59 as @e[tag=t2832_bar] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.0f, -1.421875f, -0.1875f]}}
execute if score #t2832_wave t2832_t matches 59 as @e[tag=t2832_root] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.0f, -1.984375f, 0.0f]}}

# ---- 第 60 刻（k=8，ease 1，位移 -2.0 = 终点）----
execute if score #t2832_wave t2832_t matches 60 as @e[tag=t2832_name] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.0625f, -1.8125f, -0.1875f]}}
execute if score #t2832_wave t2832_t matches 60 as @e[tag=t2832_glyph] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.0f, -1.375f, -0.1875f]}}
execute if score #t2832_wave t2832_t matches 60 as @e[tag=t2832_bar] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.0f, -1.4375f, -0.1875f]}}
execute if score #t2832_wave t2832_t matches 60 as @e[tag=t2832_root] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.0f, -2.0f, 0.0f]}}