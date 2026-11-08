# ========== title0045 逐刻关键帧（入口与驱动器都调用本函数）==========
# 时钟 #t0045_wave t0045_t → 出生当刻 = 1
#
# ★★ 为什么位置**全程逐刻一帧**（不用「一帧 + 超长 duration」）：
#   Display.onSyncedDataUpdated 里只有 `DATA_TRANSFORMATION_INTERPOLATION_START_DELTA_TICKS`
#   的**值发生变化**时才置 `updateStartTick`，进而把插值起点重置为当前刻。
#   而 `start_interpolation` 默认就是 0，我们每帧都写 0 ⇒ 值从不变 ⇒ **起点永不重置**，
#   插值进度始终相对 summon 那一帧计算 ⇒ 超长 duration 会严重提前跑完。
#   ⇒ 结论：逐刻一帧 + duration:1，进度由我们自己每刻算准（这也是 title2800 的做法）。
#
# ★★ 合并规则（沿用 title2800 的教训）：**只写「这一刻真的变了」的东西**
#   1) 位置：wave 2-107 每刻给 6 个字各写一次 translation（duration 1）。
#      wave 1 的位置 = summon 里的值，本刻不写。
#   2) I 是锚点（translation.x 恒 0）→ **任何刻都不写它**，省 106 次无效 merge。
#   3) 闪烁：每字只在自己那 5 个刻各写一次 `text`，其余刻 0 次 merge。
#   4) 位移写 transformation、闪烁写 text —— 字段不同互不干扰（SynchedEntityData.set 等值跳过）。
#
# 时间轴（刻 · 出生 = 1）：
#   1        summon：6 字 translation = k1（原串布局），text 全空（不可见）
#   2-12     缓动段：k = 1 + 0.5·三次缓入缓出((w-1)/11)，1.0 → 1.5（走完总位移的 50%）
#   13-107   线性段：k = 1.5 + 0.5·(w-12)/95，1.5 → 2.0（剩下 50% 匀速走完）
#   108      全部实体删除
#   ※ 终点宽度 = 原串 2 倍（k=2.0），I 恒为几何锚点。
#
# 闪烁（text 置空 ↔ 还原完整 component，**硬切不插值**）—— 每字 3 次闪烁 = 5 刻：
#   开头 1-10：M1 O2 B3 I4 L5 Y5 S6 起，亮灭亮灭亮（1t 一个状态）→ 停在亮（保持显示）
#   结尾 98-107：M98 O99 B100 I101 L102 Y102 S103 起，灭亮灭亮灭 → 停在灭（永久隐藏）
#   ★ 起点按**阅读顺序**递增（最左的 M 最先闪，最右的 S 最后闪）。
#   ★ 开头窗口只有 1..6 共 6 个起点，却有 7 个字 ⇒ 数学上必然有一对完全同步；
#     选了 **L 与 Y**（都在中间、颜色相近 C8BC23），观感上最不明显。
#   ★ 结尾窗口 98..103 同理，同步对同样是 L / Y。


# ---- wave 2：k = 1.0015026（缓动）----
execute if score #t0045_wave t0045_t matches 2 as @e[tag=t0045_m] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.657236f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 2 as @e[tag=t0045_o] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.394342f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 2 as @e[tag=t0045_b] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.175263f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 2 as @e[tag=t0045_l] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.131447f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 2 as @e[tag=t0045_y] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.30671f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 2 as @e[tag=t0045_s] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.569605f, 0.0f, 0.0f]}}

# ---- wave 3：k = 1.0120210（缓动）----
execute if score #t0045_wave t0045_t matches 3 as @e[tag=t0045_m] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.664139f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 3 as @e[tag=t0045_o] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.398483f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 3 as @e[tag=t0045_b] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.177104f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 3 as @e[tag=t0045_l] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.132828f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 3 as @e[tag=t0045_y] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.309931f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 3 as @e[tag=t0045_s] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.575587f, 0.0f, 0.0f]}}

# ---- wave 4：k = 1.0405710（缓动）----
execute if score #t0045_wave t0045_t matches 4 as @e[tag=t0045_m] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.682875f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 4 as @e[tag=t0045_o] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.409725f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 4 as @e[tag=t0045_b] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.1821f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 4 as @e[tag=t0045_l] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.136575f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 4 as @e[tag=t0045_y] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.318675f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 4 as @e[tag=t0045_s] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.591825f, 0.0f, 0.0f]}}

# ---- wave 5：k = 1.0961683（缓动）----
execute if score #t0045_wave t0045_t matches 5 as @e[tag=t0045_m] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.71936f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 5 as @e[tag=t0045_o] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.431616f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 5 as @e[tag=t0045_b] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.191829f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 5 as @e[tag=t0045_l] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.143872f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 5 as @e[tag=t0045_y] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.335702f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 5 as @e[tag=t0045_s] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.623446f, 0.0f, 0.0f]}}

# ---- wave 6：k = 1.1878287（缓动）----
execute if score #t0045_wave t0045_t matches 6 as @e[tag=t0045_m] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.779513f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 6 as @e[tag=t0045_o] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.467708f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 6 as @e[tag=t0045_b] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.20787f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 6 as @e[tag=t0045_l] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.155903f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 6 as @e[tag=t0045_y] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.363773f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 6 as @e[tag=t0045_s] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.675578f, 0.0f, 0.0f]}}

# ---- wave 7：k = 1.3121713（缓动）----
execute if score #t0045_wave t0045_t matches 7 as @e[tag=t0045_m] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.861112f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 7 as @e[tag=t0045_o] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.516667f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 7 as @e[tag=t0045_b] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.22963f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 7 as @e[tag=t0045_l] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.172222f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 7 as @e[tag=t0045_y] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.401852f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 7 as @e[tag=t0045_s] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.746297f, 0.0f, 0.0f]}}

# ---- wave 8：k = 1.4038317（缓动）----
execute if score #t0045_wave t0045_t matches 8 as @e[tag=t0045_m] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.921265f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 8 as @e[tag=t0045_o] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.552759f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 8 as @e[tag=t0045_b] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.245671f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 8 as @e[tag=t0045_l] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.184253f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 8 as @e[tag=t0045_y] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.429923f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 8 as @e[tag=t0045_s] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.798429f, 0.0f, 0.0f]}}

# ---- wave 9：k = 1.4594290（缓动）----
execute if score #t0045_wave t0045_t matches 9 as @e[tag=t0045_m] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.95775f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 9 as @e[tag=t0045_o] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.57465f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 9 as @e[tag=t0045_b] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.2554f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 9 as @e[tag=t0045_l] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.19155f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 9 as @e[tag=t0045_y] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.44695f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 9 as @e[tag=t0045_s] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.83005f, 0.0f, 0.0f]}}

# ---- wave 10：k = 1.4879790（缓动）----
execute if score #t0045_wave t0045_t matches 10 as @e[tag=t0045_m] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.976486f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 10 as @e[tag=t0045_o] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.585892f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 10 as @e[tag=t0045_b] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.260396f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 10 as @e[tag=t0045_l] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.195297f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 10 as @e[tag=t0045_y] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.455694f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 10 as @e[tag=t0045_s] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.846288f, 0.0f, 0.0f]}}

# ---- wave 11：k = 1.4984974（缓动）----
execute if score #t0045_wave t0045_t matches 11 as @e[tag=t0045_m] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.983389f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 11 as @e[tag=t0045_o] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.590033f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 11 as @e[tag=t0045_b] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.262237f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 11 as @e[tag=t0045_l] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.196678f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 11 as @e[tag=t0045_y] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.458915f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 11 as @e[tag=t0045_s] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.85227f, 0.0f, 0.0f]}}

# ---- wave 12：k = 1.5000000（缓动）----
execute if score #t0045_wave t0045_t matches 12 as @e[tag=t0045_m] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.984375f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 12 as @e[tag=t0045_o] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.590625f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 12 as @e[tag=t0045_b] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.2625f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 12 as @e[tag=t0045_l] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.196875f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 12 as @e[tag=t0045_y] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.459375f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 12 as @e[tag=t0045_s] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.853125f, 0.0f, 0.0f]}}

# ---- wave 13：k = 1.5052632（线性）----
execute if score #t0045_wave t0045_t matches 13 as @e[tag=t0045_m] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.987829f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 13 as @e[tag=t0045_o] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.592697f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 13 as @e[tag=t0045_b] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.263421f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 13 as @e[tag=t0045_l] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.197566f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 13 as @e[tag=t0045_y] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.460987f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 13 as @e[tag=t0045_s] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.856118f, 0.0f, 0.0f]}}

# ---- wave 14：k = 1.5105263（线性）----
execute if score #t0045_wave t0045_t matches 14 as @e[tag=t0045_m] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.991283f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 14 as @e[tag=t0045_o] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.59477f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 14 as @e[tag=t0045_b] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.264342f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 14 as @e[tag=t0045_l] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.198257f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 14 as @e[tag=t0045_y] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.462599f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 14 as @e[tag=t0045_s] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.859112f, 0.0f, 0.0f]}}

# ---- wave 15：k = 1.5157895（线性）----
execute if score #t0045_wave t0045_t matches 15 as @e[tag=t0045_m] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.994737f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 15 as @e[tag=t0045_o] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.596842f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 15 as @e[tag=t0045_b] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.265263f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 15 as @e[tag=t0045_l] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.198947f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 15 as @e[tag=t0045_y] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.464211f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 15 as @e[tag=t0045_s] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.862105f, 0.0f, 0.0f]}}

# ---- wave 16：k = 1.5210526（线性）----
execute if score #t0045_wave t0045_t matches 16 as @e[tag=t0045_m] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.998191f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 16 as @e[tag=t0045_o] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.598914f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 16 as @e[tag=t0045_b] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.266184f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 16 as @e[tag=t0045_l] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.199638f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 16 as @e[tag=t0045_y] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.465822f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 16 as @e[tag=t0045_s] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.865099f, 0.0f, 0.0f]}}

# ---- wave 17：k = 1.5263158（线性）----
execute if score #t0045_wave t0045_t matches 17 as @e[tag=t0045_m] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-1.001645f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 17 as @e[tag=t0045_o] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.600987f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 17 as @e[tag=t0045_b] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.267105f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 17 as @e[tag=t0045_l] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.200329f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 17 as @e[tag=t0045_y] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.467434f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 17 as @e[tag=t0045_s] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.868092f, 0.0f, 0.0f]}}

# ---- wave 18：k = 1.5315789（线性）----
execute if score #t0045_wave t0045_t matches 18 as @e[tag=t0045_m] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-1.005099f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 18 as @e[tag=t0045_o] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.603059f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 18 as @e[tag=t0045_b] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.268026f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 18 as @e[tag=t0045_l] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.20102f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 18 as @e[tag=t0045_y] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.469046f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 18 as @e[tag=t0045_s] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.871086f, 0.0f, 0.0f]}}

# ---- wave 19：k = 1.5368421（线性）----
execute if score #t0045_wave t0045_t matches 19 as @e[tag=t0045_m] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-1.008553f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 19 as @e[tag=t0045_o] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.605132f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 19 as @e[tag=t0045_b] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.268947f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 19 as @e[tag=t0045_l] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.201711f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 19 as @e[tag=t0045_y] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.470658f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 19 as @e[tag=t0045_s] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.874079f, 0.0f, 0.0f]}}

# ---- wave 20：k = 1.5421053（线性）----
execute if score #t0045_wave t0045_t matches 20 as @e[tag=t0045_m] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-1.012007f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 20 as @e[tag=t0045_o] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.607204f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 20 as @e[tag=t0045_b] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.269868f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 20 as @e[tag=t0045_l] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.202401f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 20 as @e[tag=t0045_y] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.47227f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 20 as @e[tag=t0045_s] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.877072f, 0.0f, 0.0f]}}

# ---- wave 21：k = 1.5473684（线性）----
execute if score #t0045_wave t0045_t matches 21 as @e[tag=t0045_m] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-1.015461f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 21 as @e[tag=t0045_o] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.609276f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 21 as @e[tag=t0045_b] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.270789f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 21 as @e[tag=t0045_l] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.203092f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 21 as @e[tag=t0045_y] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.473882f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 21 as @e[tag=t0045_s] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.880066f, 0.0f, 0.0f]}}

# ---- wave 22：k = 1.5526316（线性）----
execute if score #t0045_wave t0045_t matches 22 as @e[tag=t0045_m] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-1.018914f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 22 as @e[tag=t0045_o] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.611349f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 22 as @e[tag=t0045_b] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.271711f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 22 as @e[tag=t0045_l] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.203783f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 22 as @e[tag=t0045_y] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.475493f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 22 as @e[tag=t0045_s] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.883059f, 0.0f, 0.0f]}}

# ---- wave 23：k = 1.5578947（线性）----
execute if score #t0045_wave t0045_t matches 23 as @e[tag=t0045_m] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-1.022368f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 23 as @e[tag=t0045_o] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.613421f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 23 as @e[tag=t0045_b] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.272632f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 23 as @e[tag=t0045_l] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.204474f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 23 as @e[tag=t0045_y] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.477105f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 23 as @e[tag=t0045_s] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.886053f, 0.0f, 0.0f]}}

# ---- wave 24：k = 1.5631579（线性）----
execute if score #t0045_wave t0045_t matches 24 as @e[tag=t0045_m] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-1.025822f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 24 as @e[tag=t0045_o] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.615493f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 24 as @e[tag=t0045_b] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.273553f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 24 as @e[tag=t0045_l] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.205164f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 24 as @e[tag=t0045_y] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.478717f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 24 as @e[tag=t0045_s] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.889046f, 0.0f, 0.0f]}}

# ---- wave 25：k = 1.5684211（线性）----
execute if score #t0045_wave t0045_t matches 25 as @e[tag=t0045_m] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-1.029276f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 25 as @e[tag=t0045_o] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.617566f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 25 as @e[tag=t0045_b] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.274474f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 25 as @e[tag=t0045_l] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.205855f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 25 as @e[tag=t0045_y] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.480329f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 25 as @e[tag=t0045_s] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.892039f, 0.0f, 0.0f]}}

# ---- wave 26：k = 1.5736842（线性）----
execute if score #t0045_wave t0045_t matches 26 as @e[tag=t0045_m] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-1.03273f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 26 as @e[tag=t0045_o] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.619638f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 26 as @e[tag=t0045_b] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.275395f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 26 as @e[tag=t0045_l] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.206546f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 26 as @e[tag=t0045_y] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.481941f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 26 as @e[tag=t0045_s] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.895033f, 0.0f, 0.0f]}}

# ---- wave 27：k = 1.5789474（线性）----
execute if score #t0045_wave t0045_t matches 27 as @e[tag=t0045_m] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-1.036184f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 27 as @e[tag=t0045_o] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.621711f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 27 as @e[tag=t0045_b] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.276316f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 27 as @e[tag=t0045_l] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.207237f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 27 as @e[tag=t0045_y] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.483553f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 27 as @e[tag=t0045_s] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.898026f, 0.0f, 0.0f]}}

# ---- wave 28：k = 1.5842105（线性）----
execute if score #t0045_wave t0045_t matches 28 as @e[tag=t0045_m] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-1.039638f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 28 as @e[tag=t0045_o] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.623783f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 28 as @e[tag=t0045_b] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.277237f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 28 as @e[tag=t0045_l] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.207928f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 28 as @e[tag=t0045_y] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.485164f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 28 as @e[tag=t0045_s] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.90102f, 0.0f, 0.0f]}}

# ---- wave 29：k = 1.5894737（线性）----
execute if score #t0045_wave t0045_t matches 29 as @e[tag=t0045_m] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-1.043092f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 29 as @e[tag=t0045_o] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.625855f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 29 as @e[tag=t0045_b] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.278158f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 29 as @e[tag=t0045_l] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.208618f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 29 as @e[tag=t0045_y] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.486776f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 29 as @e[tag=t0045_s] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.904013f, 0.0f, 0.0f]}}

# ---- wave 30：k = 1.5947368（线性）----
execute if score #t0045_wave t0045_t matches 30 as @e[tag=t0045_m] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-1.046546f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 30 as @e[tag=t0045_o] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.627928f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 30 as @e[tag=t0045_b] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.279079f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 30 as @e[tag=t0045_l] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.209309f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 30 as @e[tag=t0045_y] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.488388f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 30 as @e[tag=t0045_s] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.907007f, 0.0f, 0.0f]}}

# ---- wave 31：k = 1.6000000（线性）----
execute if score #t0045_wave t0045_t matches 31 as @e[tag=t0045_m] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-1.05f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 31 as @e[tag=t0045_o] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.63f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 31 as @e[tag=t0045_b] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.28f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 31 as @e[tag=t0045_l] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.21f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 31 as @e[tag=t0045_y] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.49f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 31 as @e[tag=t0045_s] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.91f, 0.0f, 0.0f]}}

# ---- wave 32：k = 1.6052632（线性）----
execute if score #t0045_wave t0045_t matches 32 as @e[tag=t0045_m] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-1.053454f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 32 as @e[tag=t0045_o] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.632072f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 32 as @e[tag=t0045_b] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.280921f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 32 as @e[tag=t0045_l] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.210691f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 32 as @e[tag=t0045_y] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.491612f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 32 as @e[tag=t0045_s] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.912993f, 0.0f, 0.0f]}}

# ---- wave 33：k = 1.6105263（线性）----
execute if score #t0045_wave t0045_t matches 33 as @e[tag=t0045_m] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-1.056908f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 33 as @e[tag=t0045_o] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.634145f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 33 as @e[tag=t0045_b] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.281842f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 33 as @e[tag=t0045_l] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.211382f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 33 as @e[tag=t0045_y] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.493224f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 33 as @e[tag=t0045_s] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.915987f, 0.0f, 0.0f]}}

# ---- wave 34：k = 1.6157895（线性）----
execute if score #t0045_wave t0045_t matches 34 as @e[tag=t0045_m] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-1.060362f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 34 as @e[tag=t0045_o] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.636217f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 34 as @e[tag=t0045_b] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.282763f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 34 as @e[tag=t0045_l] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.212072f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 34 as @e[tag=t0045_y] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.494836f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 34 as @e[tag=t0045_s] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.91898f, 0.0f, 0.0f]}}

# ---- wave 35：k = 1.6210526（线性）----
execute if score #t0045_wave t0045_t matches 35 as @e[tag=t0045_m] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-1.063816f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 35 as @e[tag=t0045_o] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.638289f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 35 as @e[tag=t0045_b] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.283684f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 35 as @e[tag=t0045_l] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.212763f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 35 as @e[tag=t0045_y] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.496447f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 35 as @e[tag=t0045_s] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.921974f, 0.0f, 0.0f]}}

# ---- wave 36：k = 1.6263158（线性）----
execute if score #t0045_wave t0045_t matches 36 as @e[tag=t0045_m] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-1.06727f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 36 as @e[tag=t0045_o] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.640362f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 36 as @e[tag=t0045_b] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.284605f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 36 as @e[tag=t0045_l] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.213454f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 36 as @e[tag=t0045_y] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.498059f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 36 as @e[tag=t0045_s] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.924967f, 0.0f, 0.0f]}}

# ---- wave 37：k = 1.6315789（线性）----
execute if score #t0045_wave t0045_t matches 37 as @e[tag=t0045_m] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-1.070724f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 37 as @e[tag=t0045_o] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.642434f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 37 as @e[tag=t0045_b] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.285526f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 37 as @e[tag=t0045_l] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.214145f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 37 as @e[tag=t0045_y] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.499671f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 37 as @e[tag=t0045_s] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.927961f, 0.0f, 0.0f]}}

# ---- wave 38：k = 1.6368421（线性）----
execute if score #t0045_wave t0045_t matches 38 as @e[tag=t0045_m] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-1.074178f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 38 as @e[tag=t0045_o] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.644507f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 38 as @e[tag=t0045_b] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.286447f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 38 as @e[tag=t0045_l] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.214836f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 38 as @e[tag=t0045_y] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.501283f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 38 as @e[tag=t0045_s] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.930954f, 0.0f, 0.0f]}}

# ---- wave 39：k = 1.6421053（线性）----
execute if score #t0045_wave t0045_t matches 39 as @e[tag=t0045_m] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-1.077632f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 39 as @e[tag=t0045_o] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.646579f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 39 as @e[tag=t0045_b] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.287368f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 39 as @e[tag=t0045_l] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.215526f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 39 as @e[tag=t0045_y] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.502895f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 39 as @e[tag=t0045_s] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.933947f, 0.0f, 0.0f]}}

# ---- wave 40：k = 1.6473684（线性）----
execute if score #t0045_wave t0045_t matches 40 as @e[tag=t0045_m] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-1.081086f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 40 as @e[tag=t0045_o] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.648651f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 40 as @e[tag=t0045_b] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.288289f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 40 as @e[tag=t0045_l] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.216217f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 40 as @e[tag=t0045_y] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.504507f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 40 as @e[tag=t0045_s] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.936941f, 0.0f, 0.0f]}}

# ---- wave 41：k = 1.6526316（线性）----
execute if score #t0045_wave t0045_t matches 41 as @e[tag=t0045_m] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-1.084539f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 41 as @e[tag=t0045_o] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.650724f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 41 as @e[tag=t0045_b] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.289211f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 41 as @e[tag=t0045_l] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.216908f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 41 as @e[tag=t0045_y] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.506118f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 41 as @e[tag=t0045_s] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.939934f, 0.0f, 0.0f]}}

# ---- wave 42：k = 1.6578947（线性）----
execute if score #t0045_wave t0045_t matches 42 as @e[tag=t0045_m] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-1.087993f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 42 as @e[tag=t0045_o] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.652796f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 42 as @e[tag=t0045_b] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.290132f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 42 as @e[tag=t0045_l] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.217599f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 42 as @e[tag=t0045_y] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.50773f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 42 as @e[tag=t0045_s] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.942928f, 0.0f, 0.0f]}}

# ---- wave 43：k = 1.6631579（线性）----
execute if score #t0045_wave t0045_t matches 43 as @e[tag=t0045_m] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-1.091447f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 43 as @e[tag=t0045_o] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.654868f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 43 as @e[tag=t0045_b] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.291053f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 43 as @e[tag=t0045_l] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.218289f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 43 as @e[tag=t0045_y] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.509342f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 43 as @e[tag=t0045_s] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.945921f, 0.0f, 0.0f]}}

# ---- wave 44：k = 1.6684211（线性）----
execute if score #t0045_wave t0045_t matches 44 as @e[tag=t0045_m] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-1.094901f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 44 as @e[tag=t0045_o] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.656941f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 44 as @e[tag=t0045_b] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.291974f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 44 as @e[tag=t0045_l] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.21898f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 44 as @e[tag=t0045_y] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.510954f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 44 as @e[tag=t0045_s] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.948914f, 0.0f, 0.0f]}}

# ---- wave 45：k = 1.6736842（线性）----
execute if score #t0045_wave t0045_t matches 45 as @e[tag=t0045_m] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-1.098355f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 45 as @e[tag=t0045_o] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.659013f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 45 as @e[tag=t0045_b] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.292895f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 45 as @e[tag=t0045_l] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.219671f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 45 as @e[tag=t0045_y] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.512566f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 45 as @e[tag=t0045_s] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.951908f, 0.0f, 0.0f]}}

# ---- wave 46：k = 1.6789474（线性）----
execute if score #t0045_wave t0045_t matches 46 as @e[tag=t0045_m] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-1.101809f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 46 as @e[tag=t0045_o] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.661086f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 46 as @e[tag=t0045_b] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.293816f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 46 as @e[tag=t0045_l] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.220362f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 46 as @e[tag=t0045_y] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.514178f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 46 as @e[tag=t0045_s] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.954901f, 0.0f, 0.0f]}}

# ---- wave 47：k = 1.6842105（线性）----
execute if score #t0045_wave t0045_t matches 47 as @e[tag=t0045_m] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-1.105263f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 47 as @e[tag=t0045_o] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.663158f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 47 as @e[tag=t0045_b] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.294737f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 47 as @e[tag=t0045_l] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.221053f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 47 as @e[tag=t0045_y] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.515789f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 47 as @e[tag=t0045_s] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.957895f, 0.0f, 0.0f]}}

# ---- wave 48：k = 1.6894737（线性）----
execute if score #t0045_wave t0045_t matches 48 as @e[tag=t0045_m] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-1.108717f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 48 as @e[tag=t0045_o] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.66523f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 48 as @e[tag=t0045_b] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.295658f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 48 as @e[tag=t0045_l] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.221743f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 48 as @e[tag=t0045_y] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.517401f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 48 as @e[tag=t0045_s] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.960888f, 0.0f, 0.0f]}}

# ---- wave 49：k = 1.6947368（线性）----
execute if score #t0045_wave t0045_t matches 49 as @e[tag=t0045_m] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-1.112171f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 49 as @e[tag=t0045_o] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.667303f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 49 as @e[tag=t0045_b] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.296579f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 49 as @e[tag=t0045_l] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.222434f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 49 as @e[tag=t0045_y] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.519013f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 49 as @e[tag=t0045_s] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.963882f, 0.0f, 0.0f]}}

# ---- wave 50：k = 1.7000000（线性）----
execute if score #t0045_wave t0045_t matches 50 as @e[tag=t0045_m] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-1.115625f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 50 as @e[tag=t0045_o] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.669375f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 50 as @e[tag=t0045_b] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.2975f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 50 as @e[tag=t0045_l] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.223125f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 50 as @e[tag=t0045_y] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.520625f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 50 as @e[tag=t0045_s] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.966875f, 0.0f, 0.0f]}}

# ---- wave 51：k = 1.7052632（线性）----
execute if score #t0045_wave t0045_t matches 51 as @e[tag=t0045_m] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-1.119079f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 51 as @e[tag=t0045_o] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.671447f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 51 as @e[tag=t0045_b] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.298421f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 51 as @e[tag=t0045_l] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.223816f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 51 as @e[tag=t0045_y] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.522237f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 51 as @e[tag=t0045_s] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.969868f, 0.0f, 0.0f]}}

# ---- wave 52：k = 1.7105263（线性）----
execute if score #t0045_wave t0045_t matches 52 as @e[tag=t0045_m] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-1.122533f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 52 as @e[tag=t0045_o] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.67352f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 52 as @e[tag=t0045_b] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.299342f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 52 as @e[tag=t0045_l] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.224507f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 52 as @e[tag=t0045_y] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.523849f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 52 as @e[tag=t0045_s] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.972862f, 0.0f, 0.0f]}}

# ---- wave 53：k = 1.7157895（线性）----
execute if score #t0045_wave t0045_t matches 53 as @e[tag=t0045_m] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-1.125987f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 53 as @e[tag=t0045_o] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.675592f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 53 as @e[tag=t0045_b] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.300263f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 53 as @e[tag=t0045_l] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.225197f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 53 as @e[tag=t0045_y] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.525461f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 53 as @e[tag=t0045_s] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.975855f, 0.0f, 0.0f]}}

# ---- wave 54：k = 1.7210526（线性）----
execute if score #t0045_wave t0045_t matches 54 as @e[tag=t0045_m] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-1.129441f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 54 as @e[tag=t0045_o] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.677664f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 54 as @e[tag=t0045_b] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.301184f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 54 as @e[tag=t0045_l] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.225888f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 54 as @e[tag=t0045_y] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.527072f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 54 as @e[tag=t0045_s] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.978849f, 0.0f, 0.0f]}}

# ---- wave 55：k = 1.7263158（线性）----
execute if score #t0045_wave t0045_t matches 55 as @e[tag=t0045_m] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-1.132895f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 55 as @e[tag=t0045_o] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.679737f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 55 as @e[tag=t0045_b] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.302105f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 55 as @e[tag=t0045_l] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.226579f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 55 as @e[tag=t0045_y] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.528684f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 55 as @e[tag=t0045_s] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.981842f, 0.0f, 0.0f]}}

# ---- wave 56：k = 1.7315789（线性）----
execute if score #t0045_wave t0045_t matches 56 as @e[tag=t0045_m] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-1.136349f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 56 as @e[tag=t0045_o] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.681809f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 56 as @e[tag=t0045_b] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.303026f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 56 as @e[tag=t0045_l] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.22727f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 56 as @e[tag=t0045_y] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.530296f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 56 as @e[tag=t0045_s] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.984836f, 0.0f, 0.0f]}}

# ---- wave 57：k = 1.7368421（线性）----
execute if score #t0045_wave t0045_t matches 57 as @e[tag=t0045_m] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-1.139803f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 57 as @e[tag=t0045_o] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.683882f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 57 as @e[tag=t0045_b] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.303947f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 57 as @e[tag=t0045_l] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.227961f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 57 as @e[tag=t0045_y] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.531908f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 57 as @e[tag=t0045_s] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.987829f, 0.0f, 0.0f]}}

# ---- wave 58：k = 1.7421053（线性）----
execute if score #t0045_wave t0045_t matches 58 as @e[tag=t0045_m] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-1.143257f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 58 as @e[tag=t0045_o] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.685954f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 58 as @e[tag=t0045_b] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.304868f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 58 as @e[tag=t0045_l] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.228651f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 58 as @e[tag=t0045_y] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.53352f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 58 as @e[tag=t0045_s] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.990822f, 0.0f, 0.0f]}}

# ---- wave 59：k = 1.7473684（线性）----
execute if score #t0045_wave t0045_t matches 59 as @e[tag=t0045_m] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-1.146711f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 59 as @e[tag=t0045_o] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.688026f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 59 as @e[tag=t0045_b] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.305789f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 59 as @e[tag=t0045_l] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.229342f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 59 as @e[tag=t0045_y] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.535132f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 59 as @e[tag=t0045_s] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.993816f, 0.0f, 0.0f]}}

# ---- wave 60：k = 1.7526316（线性）----
execute if score #t0045_wave t0045_t matches 60 as @e[tag=t0045_m] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-1.150164f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 60 as @e[tag=t0045_o] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.690099f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 60 as @e[tag=t0045_b] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.306711f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 60 as @e[tag=t0045_l] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.230033f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 60 as @e[tag=t0045_y] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.536743f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 60 as @e[tag=t0045_s] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.996809f, 0.0f, 0.0f]}}

# ---- wave 61：k = 1.7578947（线性）----
execute if score #t0045_wave t0045_t matches 61 as @e[tag=t0045_m] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-1.153618f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 61 as @e[tag=t0045_o] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.692171f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 61 as @e[tag=t0045_b] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.307632f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 61 as @e[tag=t0045_l] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.230724f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 61 as @e[tag=t0045_y] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.538355f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 61 as @e[tag=t0045_s] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.999803f, 0.0f, 0.0f]}}

# ---- wave 62：k = 1.7631579（线性）----
execute if score #t0045_wave t0045_t matches 62 as @e[tag=t0045_m] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-1.157072f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 62 as @e[tag=t0045_o] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.694243f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 62 as @e[tag=t0045_b] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.308553f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 62 as @e[tag=t0045_l] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.231414f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 62 as @e[tag=t0045_y] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.539967f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 62 as @e[tag=t0045_s] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [1.002796f, 0.0f, 0.0f]}}

# ---- wave 63：k = 1.7684211（线性）----
execute if score #t0045_wave t0045_t matches 63 as @e[tag=t0045_m] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-1.160526f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 63 as @e[tag=t0045_o] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.696316f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 63 as @e[tag=t0045_b] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.309474f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 63 as @e[tag=t0045_l] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.232105f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 63 as @e[tag=t0045_y] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.541579f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 63 as @e[tag=t0045_s] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [1.005789f, 0.0f, 0.0f]}}

# ---- wave 64：k = 1.7736842（线性）----
execute if score #t0045_wave t0045_t matches 64 as @e[tag=t0045_m] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-1.16398f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 64 as @e[tag=t0045_o] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.698388f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 64 as @e[tag=t0045_b] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.310395f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 64 as @e[tag=t0045_l] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.232796f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 64 as @e[tag=t0045_y] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.543191f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 64 as @e[tag=t0045_s] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [1.008783f, 0.0f, 0.0f]}}

# ---- wave 65：k = 1.7789474（线性）----
execute if score #t0045_wave t0045_t matches 65 as @e[tag=t0045_m] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-1.167434f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 65 as @e[tag=t0045_o] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.700461f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 65 as @e[tag=t0045_b] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.311316f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 65 as @e[tag=t0045_l] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.233487f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 65 as @e[tag=t0045_y] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.544803f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 65 as @e[tag=t0045_s] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [1.011776f, 0.0f, 0.0f]}}

# ---- wave 66：k = 1.7842105（线性）----
execute if score #t0045_wave t0045_t matches 66 as @e[tag=t0045_m] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-1.170888f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 66 as @e[tag=t0045_o] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.702533f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 66 as @e[tag=t0045_b] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.312237f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 66 as @e[tag=t0045_l] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.234178f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 66 as @e[tag=t0045_y] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.546414f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 66 as @e[tag=t0045_s] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [1.01477f, 0.0f, 0.0f]}}

# ---- wave 67：k = 1.7894737（线性）----
execute if score #t0045_wave t0045_t matches 67 as @e[tag=t0045_m] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-1.174342f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 67 as @e[tag=t0045_o] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.704605f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 67 as @e[tag=t0045_b] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.313158f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 67 as @e[tag=t0045_l] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.234868f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 67 as @e[tag=t0045_y] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.548026f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 67 as @e[tag=t0045_s] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [1.017763f, 0.0f, 0.0f]}}

# ---- wave 68：k = 1.7947368（线性）----
execute if score #t0045_wave t0045_t matches 68 as @e[tag=t0045_m] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-1.177796f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 68 as @e[tag=t0045_o] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.706678f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 68 as @e[tag=t0045_b] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.314079f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 68 as @e[tag=t0045_l] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.235559f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 68 as @e[tag=t0045_y] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.549638f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 68 as @e[tag=t0045_s] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [1.020757f, 0.0f, 0.0f]}}

# ---- wave 69：k = 1.8000000（线性）----
execute if score #t0045_wave t0045_t matches 69 as @e[tag=t0045_m] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-1.18125f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 69 as @e[tag=t0045_o] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.70875f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 69 as @e[tag=t0045_b] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.315f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 69 as @e[tag=t0045_l] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.23625f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 69 as @e[tag=t0045_y] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.55125f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 69 as @e[tag=t0045_s] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [1.02375f, 0.0f, 0.0f]}}

# ---- wave 70：k = 1.8052632（线性）----
execute if score #t0045_wave t0045_t matches 70 as @e[tag=t0045_m] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-1.184704f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 70 as @e[tag=t0045_o] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.710822f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 70 as @e[tag=t0045_b] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.315921f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 70 as @e[tag=t0045_l] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.236941f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 70 as @e[tag=t0045_y] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.552862f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 70 as @e[tag=t0045_s] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [1.026743f, 0.0f, 0.0f]}}

# ---- wave 71：k = 1.8105263（线性）----
execute if score #t0045_wave t0045_t matches 71 as @e[tag=t0045_m] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-1.188158f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 71 as @e[tag=t0045_o] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.712895f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 71 as @e[tag=t0045_b] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.316842f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 71 as @e[tag=t0045_l] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.237632f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 71 as @e[tag=t0045_y] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.554474f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 71 as @e[tag=t0045_s] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [1.029737f, 0.0f, 0.0f]}}

# ---- wave 72：k = 1.8157895（线性）----
execute if score #t0045_wave t0045_t matches 72 as @e[tag=t0045_m] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-1.191612f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 72 as @e[tag=t0045_o] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.714967f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 72 as @e[tag=t0045_b] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.317763f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 72 as @e[tag=t0045_l] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.238322f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 72 as @e[tag=t0045_y] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.556086f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 72 as @e[tag=t0045_s] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [1.03273f, 0.0f, 0.0f]}}

# ---- wave 73：k = 1.8210526（线性）----
execute if score #t0045_wave t0045_t matches 73 as @e[tag=t0045_m] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-1.195066f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 73 as @e[tag=t0045_o] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.717039f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 73 as @e[tag=t0045_b] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.318684f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 73 as @e[tag=t0045_l] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.239013f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 73 as @e[tag=t0045_y] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.557697f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 73 as @e[tag=t0045_s] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [1.035724f, 0.0f, 0.0f]}}

# ---- wave 74：k = 1.8263158（线性）----
execute if score #t0045_wave t0045_t matches 74 as @e[tag=t0045_m] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-1.19852f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 74 as @e[tag=t0045_o] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.719112f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 74 as @e[tag=t0045_b] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.319605f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 74 as @e[tag=t0045_l] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.239704f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 74 as @e[tag=t0045_y] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.559309f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 74 as @e[tag=t0045_s] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [1.038717f, 0.0f, 0.0f]}}

# ---- wave 75：k = 1.8315789（线性）----
execute if score #t0045_wave t0045_t matches 75 as @e[tag=t0045_m] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-1.201974f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 75 as @e[tag=t0045_o] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.721184f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 75 as @e[tag=t0045_b] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.320526f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 75 as @e[tag=t0045_l] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.240395f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 75 as @e[tag=t0045_y] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.560921f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 75 as @e[tag=t0045_s] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [1.041711f, 0.0f, 0.0f]}}

# ---- wave 76：k = 1.8368421（线性）----
execute if score #t0045_wave t0045_t matches 76 as @e[tag=t0045_m] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-1.205428f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 76 as @e[tag=t0045_o] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.723257f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 76 as @e[tag=t0045_b] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.321447f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 76 as @e[tag=t0045_l] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.241086f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 76 as @e[tag=t0045_y] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.562533f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 76 as @e[tag=t0045_s] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [1.044704f, 0.0f, 0.0f]}}

# ---- wave 77：k = 1.8421053（线性）----
execute if score #t0045_wave t0045_t matches 77 as @e[tag=t0045_m] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-1.208882f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 77 as @e[tag=t0045_o] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.725329f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 77 as @e[tag=t0045_b] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.322368f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 77 as @e[tag=t0045_l] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.241776f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 77 as @e[tag=t0045_y] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.564145f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 77 as @e[tag=t0045_s] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [1.047697f, 0.0f, 0.0f]}}

# ---- wave 78：k = 1.8473684（线性）----
execute if score #t0045_wave t0045_t matches 78 as @e[tag=t0045_m] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-1.212336f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 78 as @e[tag=t0045_o] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.727401f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 78 as @e[tag=t0045_b] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.323289f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 78 as @e[tag=t0045_l] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.242467f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 78 as @e[tag=t0045_y] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.565757f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 78 as @e[tag=t0045_s] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [1.050691f, 0.0f, 0.0f]}}

# ---- wave 79：k = 1.8526316（线性）----
execute if score #t0045_wave t0045_t matches 79 as @e[tag=t0045_m] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-1.215789f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 79 as @e[tag=t0045_o] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.729474f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 79 as @e[tag=t0045_b] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.324211f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 79 as @e[tag=t0045_l] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.243158f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 79 as @e[tag=t0045_y] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.567368f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 79 as @e[tag=t0045_s] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [1.053684f, 0.0f, 0.0f]}}

# ---- wave 80：k = 1.8578947（线性）----
execute if score #t0045_wave t0045_t matches 80 as @e[tag=t0045_m] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-1.219243f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 80 as @e[tag=t0045_o] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.731546f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 80 as @e[tag=t0045_b] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.325132f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 80 as @e[tag=t0045_l] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.243849f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 80 as @e[tag=t0045_y] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.56898f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 80 as @e[tag=t0045_s] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [1.056678f, 0.0f, 0.0f]}}

# ---- wave 81：k = 1.8631579（线性）----
execute if score #t0045_wave t0045_t matches 81 as @e[tag=t0045_m] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-1.222697f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 81 as @e[tag=t0045_o] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.733618f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 81 as @e[tag=t0045_b] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.326053f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 81 as @e[tag=t0045_l] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.244539f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 81 as @e[tag=t0045_y] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.570592f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 81 as @e[tag=t0045_s] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [1.059671f, 0.0f, 0.0f]}}

# ---- wave 82：k = 1.8684211（线性）----
execute if score #t0045_wave t0045_t matches 82 as @e[tag=t0045_m] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-1.226151f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 82 as @e[tag=t0045_o] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.735691f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 82 as @e[tag=t0045_b] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.326974f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 82 as @e[tag=t0045_l] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.24523f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 82 as @e[tag=t0045_y] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.572204f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 82 as @e[tag=t0045_s] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [1.062664f, 0.0f, 0.0f]}}

# ---- wave 83：k = 1.8736842（线性）----
execute if score #t0045_wave t0045_t matches 83 as @e[tag=t0045_m] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-1.229605f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 83 as @e[tag=t0045_o] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.737763f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 83 as @e[tag=t0045_b] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.327895f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 83 as @e[tag=t0045_l] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.245921f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 83 as @e[tag=t0045_y] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.573816f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 83 as @e[tag=t0045_s] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [1.065658f, 0.0f, 0.0f]}}

# ---- wave 84：k = 1.8789474（线性）----
execute if score #t0045_wave t0045_t matches 84 as @e[tag=t0045_m] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-1.233059f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 84 as @e[tag=t0045_o] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.739836f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 84 as @e[tag=t0045_b] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.328816f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 84 as @e[tag=t0045_l] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.246612f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 84 as @e[tag=t0045_y] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.575428f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 84 as @e[tag=t0045_s] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [1.068651f, 0.0f, 0.0f]}}

# ---- wave 85：k = 1.8842105（线性）----
execute if score #t0045_wave t0045_t matches 85 as @e[tag=t0045_m] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-1.236513f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 85 as @e[tag=t0045_o] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.741908f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 85 as @e[tag=t0045_b] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.329737f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 85 as @e[tag=t0045_l] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.247303f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 85 as @e[tag=t0045_y] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.577039f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 85 as @e[tag=t0045_s] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [1.071645f, 0.0f, 0.0f]}}

# ---- wave 86：k = 1.8894737（线性）----
execute if score #t0045_wave t0045_t matches 86 as @e[tag=t0045_m] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-1.239967f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 86 as @e[tag=t0045_o] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.74398f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 86 as @e[tag=t0045_b] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.330658f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 86 as @e[tag=t0045_l] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.247993f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 86 as @e[tag=t0045_y] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.578651f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 86 as @e[tag=t0045_s] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [1.074638f, 0.0f, 0.0f]}}

# ---- wave 87：k = 1.8947368（线性）----
execute if score #t0045_wave t0045_t matches 87 as @e[tag=t0045_m] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-1.243421f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 87 as @e[tag=t0045_o] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.746053f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 87 as @e[tag=t0045_b] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.331579f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 87 as @e[tag=t0045_l] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.248684f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 87 as @e[tag=t0045_y] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.580263f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 87 as @e[tag=t0045_s] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [1.077632f, 0.0f, 0.0f]}}

# ---- wave 88：k = 1.9000000（线性）----
execute if score #t0045_wave t0045_t matches 88 as @e[tag=t0045_m] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-1.246875f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 88 as @e[tag=t0045_o] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.748125f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 88 as @e[tag=t0045_b] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.3325f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 88 as @e[tag=t0045_l] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.249375f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 88 as @e[tag=t0045_y] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.581875f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 88 as @e[tag=t0045_s] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [1.080625f, 0.0f, 0.0f]}}

# ---- wave 89：k = 1.9052632（线性）----
execute if score #t0045_wave t0045_t matches 89 as @e[tag=t0045_m] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-1.250329f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 89 as @e[tag=t0045_o] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.750197f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 89 as @e[tag=t0045_b] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.333421f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 89 as @e[tag=t0045_l] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.250066f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 89 as @e[tag=t0045_y] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.583487f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 89 as @e[tag=t0045_s] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [1.083618f, 0.0f, 0.0f]}}

# ---- wave 90：k = 1.9105263（线性）----
execute if score #t0045_wave t0045_t matches 90 as @e[tag=t0045_m] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-1.253783f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 90 as @e[tag=t0045_o] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.75227f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 90 as @e[tag=t0045_b] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.334342f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 90 as @e[tag=t0045_l] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.250757f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 90 as @e[tag=t0045_y] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.585099f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 90 as @e[tag=t0045_s] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [1.086612f, 0.0f, 0.0f]}}

# ---- wave 91：k = 1.9157895（线性）----
execute if score #t0045_wave t0045_t matches 91 as @e[tag=t0045_m] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-1.257237f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 91 as @e[tag=t0045_o] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.754342f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 91 as @e[tag=t0045_b] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.335263f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 91 as @e[tag=t0045_l] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.251447f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 91 as @e[tag=t0045_y] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.586711f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 91 as @e[tag=t0045_s] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [1.089605f, 0.0f, 0.0f]}}

# ---- wave 92：k = 1.9210526（线性）----
execute if score #t0045_wave t0045_t matches 92 as @e[tag=t0045_m] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-1.260691f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 92 as @e[tag=t0045_o] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.756414f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 92 as @e[tag=t0045_b] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.336184f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 92 as @e[tag=t0045_l] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.252138f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 92 as @e[tag=t0045_y] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.588322f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 92 as @e[tag=t0045_s] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [1.092599f, 0.0f, 0.0f]}}

# ---- wave 93：k = 1.9263158（线性）----
execute if score #t0045_wave t0045_t matches 93 as @e[tag=t0045_m] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-1.264145f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 93 as @e[tag=t0045_o] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.758487f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 93 as @e[tag=t0045_b] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.337105f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 93 as @e[tag=t0045_l] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.252829f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 93 as @e[tag=t0045_y] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.589934f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 93 as @e[tag=t0045_s] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [1.095592f, 0.0f, 0.0f]}}

# ---- wave 94：k = 1.9315789（线性）----
execute if score #t0045_wave t0045_t matches 94 as @e[tag=t0045_m] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-1.267599f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 94 as @e[tag=t0045_o] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.760559f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 94 as @e[tag=t0045_b] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.338026f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 94 as @e[tag=t0045_l] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.25352f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 94 as @e[tag=t0045_y] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.591546f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 94 as @e[tag=t0045_s] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [1.098586f, 0.0f, 0.0f]}}

# ---- wave 95：k = 1.9368421（线性）----
execute if score #t0045_wave t0045_t matches 95 as @e[tag=t0045_m] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-1.271053f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 95 as @e[tag=t0045_o] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.762632f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 95 as @e[tag=t0045_b] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.338947f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 95 as @e[tag=t0045_l] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.254211f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 95 as @e[tag=t0045_y] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.593158f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 95 as @e[tag=t0045_s] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [1.101579f, 0.0f, 0.0f]}}

# ---- wave 96：k = 1.9421053（线性）----
execute if score #t0045_wave t0045_t matches 96 as @e[tag=t0045_m] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-1.274507f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 96 as @e[tag=t0045_o] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.764704f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 96 as @e[tag=t0045_b] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.339868f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 96 as @e[tag=t0045_l] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.254901f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 96 as @e[tag=t0045_y] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.59477f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 96 as @e[tag=t0045_s] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [1.104572f, 0.0f, 0.0f]}}

# ---- wave 97：k = 1.9473684（线性）----
execute if score #t0045_wave t0045_t matches 97 as @e[tag=t0045_m] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-1.277961f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 97 as @e[tag=t0045_o] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.766776f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 97 as @e[tag=t0045_b] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.340789f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 97 as @e[tag=t0045_l] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.255592f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 97 as @e[tag=t0045_y] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.596382f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 97 as @e[tag=t0045_s] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [1.107566f, 0.0f, 0.0f]}}

# ---- wave 98：k = 1.9526316（线性）----
execute if score #t0045_wave t0045_t matches 98 as @e[tag=t0045_m] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-1.281414f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 98 as @e[tag=t0045_o] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.768849f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 98 as @e[tag=t0045_b] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.341711f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 98 as @e[tag=t0045_l] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.256283f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 98 as @e[tag=t0045_y] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.597993f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 98 as @e[tag=t0045_s] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [1.110559f, 0.0f, 0.0f]}}

# ---- wave 99：k = 1.9578947（线性）----
execute if score #t0045_wave t0045_t matches 99 as @e[tag=t0045_m] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-1.284868f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 99 as @e[tag=t0045_o] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.770921f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 99 as @e[tag=t0045_b] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.342632f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 99 as @e[tag=t0045_l] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.256974f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 99 as @e[tag=t0045_y] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.599605f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 99 as @e[tag=t0045_s] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [1.113553f, 0.0f, 0.0f]}}

# ---- wave 100：k = 1.9631579（线性）----
execute if score #t0045_wave t0045_t matches 100 as @e[tag=t0045_m] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-1.288322f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 100 as @e[tag=t0045_o] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.772993f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 100 as @e[tag=t0045_b] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.343553f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 100 as @e[tag=t0045_l] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.257664f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 100 as @e[tag=t0045_y] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.601217f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 100 as @e[tag=t0045_s] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [1.116546f, 0.0f, 0.0f]}}

# ---- wave 101：k = 1.9684211（线性）----
execute if score #t0045_wave t0045_t matches 101 as @e[tag=t0045_m] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-1.291776f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 101 as @e[tag=t0045_o] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.775066f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 101 as @e[tag=t0045_b] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.344474f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 101 as @e[tag=t0045_l] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.258355f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 101 as @e[tag=t0045_y] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.602829f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 101 as @e[tag=t0045_s] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [1.119539f, 0.0f, 0.0f]}}

# ---- wave 102：k = 1.9736842（线性）----
execute if score #t0045_wave t0045_t matches 102 as @e[tag=t0045_m] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-1.29523f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 102 as @e[tag=t0045_o] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.777138f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 102 as @e[tag=t0045_b] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.345395f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 102 as @e[tag=t0045_l] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.259046f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 102 as @e[tag=t0045_y] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.604441f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 102 as @e[tag=t0045_s] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [1.122533f, 0.0f, 0.0f]}}

# ---- wave 103：k = 1.9789474（线性）----
execute if score #t0045_wave t0045_t matches 103 as @e[tag=t0045_m] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-1.298684f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 103 as @e[tag=t0045_o] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.779211f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 103 as @e[tag=t0045_b] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.346316f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 103 as @e[tag=t0045_l] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.259737f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 103 as @e[tag=t0045_y] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.606053f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 103 as @e[tag=t0045_s] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [1.125526f, 0.0f, 0.0f]}}

# ---- wave 104：k = 1.9842105（线性）----
execute if score #t0045_wave t0045_t matches 104 as @e[tag=t0045_m] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-1.302138f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 104 as @e[tag=t0045_o] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.781283f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 104 as @e[tag=t0045_b] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.347237f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 104 as @e[tag=t0045_l] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.260428f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 104 as @e[tag=t0045_y] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.607664f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 104 as @e[tag=t0045_s] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [1.12852f, 0.0f, 0.0f]}}

# ---- wave 105：k = 1.9894737（线性）----
execute if score #t0045_wave t0045_t matches 105 as @e[tag=t0045_m] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-1.305592f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 105 as @e[tag=t0045_o] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.783355f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 105 as @e[tag=t0045_b] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.348158f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 105 as @e[tag=t0045_l] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.261118f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 105 as @e[tag=t0045_y] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.609276f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 105 as @e[tag=t0045_s] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [1.131513f, 0.0f, 0.0f]}}

# ---- wave 106：k = 1.9947368（线性）----
execute if score #t0045_wave t0045_t matches 106 as @e[tag=t0045_m] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-1.309046f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 106 as @e[tag=t0045_o] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.785428f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 106 as @e[tag=t0045_b] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.349079f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 106 as @e[tag=t0045_l] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.261809f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 106 as @e[tag=t0045_y] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.610888f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 106 as @e[tag=t0045_s] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [1.134507f, 0.0f, 0.0f]}}

# ---- wave 107：k = 2.0000000（线性）----
execute if score #t0045_wave t0045_t matches 107 as @e[tag=t0045_m] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-1.3125f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 107 as @e[tag=t0045_o] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.7875f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 107 as @e[tag=t0045_b] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [-0.35f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 107 as @e[tag=t0045_l] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.2625f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 107 as @e[tag=t0045_y] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [0.6125f, 0.0f, 0.0f]}}
execute if score #t0045_wave t0045_t matches 107 as @e[tag=t0045_s] run data merge entity @s {start_interpolation: 0, interpolation_duration: 1, transformation: {translation: [1.1375f, 0.0f, 0.0f]}}

# ---- 刻 1（开头闪烁）----
execute if score #t0045_wave t0045_t matches 1 as @e[tag=t0045_m] run data merge entity @s {text: {color: "#5A821C", text: "M"}}

# ---- 刻 2（开头闪烁）----
execute if score #t0045_wave t0045_t matches 2 as @e[tag=t0045_m] run data merge entity @s {text: ""}
execute if score #t0045_wave t0045_t matches 2 as @e[tag=t0045_o] run data merge entity @s {text: {color: "#FED826", text: "O"}}

# ---- 刻 3（开头闪烁）----
execute if score #t0045_wave t0045_t matches 3 as @e[tag=t0045_m] run data merge entity @s {text: {color: "#5A821C", text: "M"}}
execute if score #t0045_wave t0045_t matches 3 as @e[tag=t0045_o] run data merge entity @s {text: ""}
execute if score #t0045_wave t0045_t matches 3 as @e[tag=t0045_b] run data merge entity @s {text: {color: "#FED826", text: "B"}}

# ---- 刻 4（开头闪烁）----
execute if score #t0045_wave t0045_t matches 4 as @e[tag=t0045_m] run data merge entity @s {text: ""}
execute if score #t0045_wave t0045_t matches 4 as @e[tag=t0045_o] run data merge entity @s {text: {color: "#FED826", text: "O"}}
execute if score #t0045_wave t0045_t matches 4 as @e[tag=t0045_b] run data merge entity @s {text: ""}
execute if score #t0045_wave t0045_t matches 4 as @e[tag=t0045_i] run data merge entity @s {text: {color: "#FFD927", text: "I"}}

# ---- 刻 5（开头闪烁）----
execute if score #t0045_wave t0045_t matches 5 as @e[tag=t0045_m] run data merge entity @s {text: {color: "#5A821C", text: "M"}}
execute if score #t0045_wave t0045_t matches 5 as @e[tag=t0045_o] run data merge entity @s {text: ""}
execute if score #t0045_wave t0045_t matches 5 as @e[tag=t0045_b] run data merge entity @s {text: {color: "#FED826", text: "B"}}
execute if score #t0045_wave t0045_t matches 5 as @e[tag=t0045_i] run data merge entity @s {text: ""}
execute if score #t0045_wave t0045_t matches 5 as @e[tag=t0045_l] run data merge entity @s {text: {color: "#C8BC23", text: "L"}}
execute if score #t0045_wave t0045_t matches 5 as @e[tag=t0045_y] run data merge entity @s {text: {color: "#C8BC23", text: "Y"}}

# ---- 刻 6（开头闪烁）----
execute if score #t0045_wave t0045_t matches 6 as @e[tag=t0045_o] run data merge entity @s {text: {color: "#FED826", text: "O"}}
execute if score #t0045_wave t0045_t matches 6 as @e[tag=t0045_b] run data merge entity @s {text: ""}
execute if score #t0045_wave t0045_t matches 6 as @e[tag=t0045_i] run data merge entity @s {text: {color: "#FFD927", text: "I"}}
execute if score #t0045_wave t0045_t matches 6 as @e[tag=t0045_l] run data merge entity @s {text: ""}
execute if score #t0045_wave t0045_t matches 6 as @e[tag=t0045_y] run data merge entity @s {text: ""}
execute if score #t0045_wave t0045_t matches 6 as @e[tag=t0045_s] run data merge entity @s {text: {color: "#5A821B", text: "S"}}

# ---- 刻 7（开头闪烁）----
execute if score #t0045_wave t0045_t matches 7 as @e[tag=t0045_b] run data merge entity @s {text: {color: "#FED826", text: "B"}}
execute if score #t0045_wave t0045_t matches 7 as @e[tag=t0045_i] run data merge entity @s {text: ""}
execute if score #t0045_wave t0045_t matches 7 as @e[tag=t0045_l] run data merge entity @s {text: {color: "#C8BC23", text: "L"}}
execute if score #t0045_wave t0045_t matches 7 as @e[tag=t0045_y] run data merge entity @s {text: {color: "#C8BC23", text: "Y"}}
execute if score #t0045_wave t0045_t matches 7 as @e[tag=t0045_s] run data merge entity @s {text: ""}

# ---- 刻 8（开头闪烁）----
execute if score #t0045_wave t0045_t matches 8 as @e[tag=t0045_i] run data merge entity @s {text: {color: "#FFD927", text: "I"}}
execute if score #t0045_wave t0045_t matches 8 as @e[tag=t0045_l] run data merge entity @s {text: ""}
execute if score #t0045_wave t0045_t matches 8 as @e[tag=t0045_y] run data merge entity @s {text: ""}
execute if score #t0045_wave t0045_t matches 8 as @e[tag=t0045_s] run data merge entity @s {text: {color: "#5A821B", text: "S"}}

# ---- 刻 9（开头闪烁）----
execute if score #t0045_wave t0045_t matches 9 as @e[tag=t0045_l] run data merge entity @s {text: {color: "#C8BC23", text: "L"}}
execute if score #t0045_wave t0045_t matches 9 as @e[tag=t0045_y] run data merge entity @s {text: {color: "#C8BC23", text: "Y"}}
execute if score #t0045_wave t0045_t matches 9 as @e[tag=t0045_s] run data merge entity @s {text: ""}

# ---- 刻 10（开头闪烁）----
execute if score #t0045_wave t0045_t matches 10 as @e[tag=t0045_s] run data merge entity @s {text: {color: "#5A821B", text: "S"}}

# ---- 刻 98（结尾闪烁）----
execute if score #t0045_wave t0045_t matches 98 as @e[tag=t0045_m] run data merge entity @s {text: ""}

# ---- 刻 99（结尾闪烁）----
execute if score #t0045_wave t0045_t matches 99 as @e[tag=t0045_m] run data merge entity @s {text: {color: "#5A821C", text: "M"}}
execute if score #t0045_wave t0045_t matches 99 as @e[tag=t0045_o] run data merge entity @s {text: ""}

# ---- 刻 100（结尾闪烁）----
execute if score #t0045_wave t0045_t matches 100 as @e[tag=t0045_m] run data merge entity @s {text: ""}
execute if score #t0045_wave t0045_t matches 100 as @e[tag=t0045_o] run data merge entity @s {text: {color: "#FED826", text: "O"}}
execute if score #t0045_wave t0045_t matches 100 as @e[tag=t0045_b] run data merge entity @s {text: ""}

# ---- 刻 101（结尾闪烁）----
execute if score #t0045_wave t0045_t matches 101 as @e[tag=t0045_m] run data merge entity @s {text: {color: "#5A821C", text: "M"}}
execute if score #t0045_wave t0045_t matches 101 as @e[tag=t0045_o] run data merge entity @s {text: ""}
execute if score #t0045_wave t0045_t matches 101 as @e[tag=t0045_b] run data merge entity @s {text: {color: "#FED826", text: "B"}}
execute if score #t0045_wave t0045_t matches 101 as @e[tag=t0045_i] run data merge entity @s {text: ""}

# ---- 刻 102（结尾闪烁）----
execute if score #t0045_wave t0045_t matches 102 as @e[tag=t0045_m] run data merge entity @s {text: ""}
execute if score #t0045_wave t0045_t matches 102 as @e[tag=t0045_o] run data merge entity @s {text: {color: "#FED826", text: "O"}}
execute if score #t0045_wave t0045_t matches 102 as @e[tag=t0045_b] run data merge entity @s {text: ""}
execute if score #t0045_wave t0045_t matches 102 as @e[tag=t0045_i] run data merge entity @s {text: {color: "#FFD927", text: "I"}}
execute if score #t0045_wave t0045_t matches 102 as @e[tag=t0045_l] run data merge entity @s {text: ""}
execute if score #t0045_wave t0045_t matches 102 as @e[tag=t0045_y] run data merge entity @s {text: ""}

# ---- 刻 103（结尾闪烁）----
execute if score #t0045_wave t0045_t matches 103 as @e[tag=t0045_o] run data merge entity @s {text: ""}
execute if score #t0045_wave t0045_t matches 103 as @e[tag=t0045_b] run data merge entity @s {text: {color: "#FED826", text: "B"}}
execute if score #t0045_wave t0045_t matches 103 as @e[tag=t0045_i] run data merge entity @s {text: ""}
execute if score #t0045_wave t0045_t matches 103 as @e[tag=t0045_l] run data merge entity @s {text: {color: "#C8BC23", text: "L"}}
execute if score #t0045_wave t0045_t matches 103 as @e[tag=t0045_y] run data merge entity @s {text: {color: "#C8BC23", text: "Y"}}
execute if score #t0045_wave t0045_t matches 103 as @e[tag=t0045_s] run data merge entity @s {text: ""}

# ---- 刻 104（结尾闪烁）----
execute if score #t0045_wave t0045_t matches 104 as @e[tag=t0045_b] run data merge entity @s {text: ""}
execute if score #t0045_wave t0045_t matches 104 as @e[tag=t0045_i] run data merge entity @s {text: {color: "#FFD927", text: "I"}}
execute if score #t0045_wave t0045_t matches 104 as @e[tag=t0045_l] run data merge entity @s {text: ""}
execute if score #t0045_wave t0045_t matches 104 as @e[tag=t0045_y] run data merge entity @s {text: ""}
execute if score #t0045_wave t0045_t matches 104 as @e[tag=t0045_s] run data merge entity @s {text: {color: "#5A821B", text: "S"}}

# ---- 刻 105（结尾闪烁）----
execute if score #t0045_wave t0045_t matches 105 as @e[tag=t0045_i] run data merge entity @s {text: ""}
execute if score #t0045_wave t0045_t matches 105 as @e[tag=t0045_l] run data merge entity @s {text: {color: "#C8BC23", text: "L"}}
execute if score #t0045_wave t0045_t matches 105 as @e[tag=t0045_y] run data merge entity @s {text: {color: "#C8BC23", text: "Y"}}
execute if score #t0045_wave t0045_t matches 105 as @e[tag=t0045_s] run data merge entity @s {text: ""}

# ---- 刻 106（结尾闪烁）----
execute if score #t0045_wave t0045_t matches 106 as @e[tag=t0045_l] run data merge entity @s {text: ""}
execute if score #t0045_wave t0045_t matches 106 as @e[tag=t0045_y] run data merge entity @s {text: ""}
execute if score #t0045_wave t0045_t matches 106 as @e[tag=t0045_s] run data merge entity @s {text: {color: "#5A821B", text: "S"}}

# ---- 刻 107（结尾闪烁）----
execute if score #t0045_wave t0045_t matches 107 as @e[tag=t0045_s] run data merge entity @s {text: ""}
