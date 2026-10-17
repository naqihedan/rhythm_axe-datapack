# ========== title_youwin 逐段关键帧（入口与驱动器都调用本函数）==========
# 时钟 #youwin_wave youwin_t → 出生当刻 = 1
#
# ★★ 每段只在段首下发一帧「该段的末状态」，之后不再 merge：
#    客户端拿「当前值 → 这一帧」自己插值（interpolation_duration = 段长）。
#    · 逐刻 merge 会每刻重置插值起点 ⇒ 反复抽搐（letter2768 已踩）
#    · start_interpolation: 0 必须写（立刻从当前值开始插值）
#
# ★ 长条「从一端向另一端长出来 / 再原路退回」的原理：
#   展示实体的缩放围绕**自身原点**，不能靠 left_rotation 换轴，所以要把原点搬到固定端。
#   设满态中心 C、满态长度 S（只缩生长轴）、固定端锚点 A = C + fs·S/2。
#   端点位置 = translation ± scale/2；令 translation 与 scale 同步线性变化即可锁住 A：
#     生长：出生 (A, 长度0)  ──▶  段1末 (C, 长度S)   固定 A 端，另一端向外扫出整条线
#     缩回：段3始 (C, 长度S)  ──▶  段3末 (A, 长度0)   同一锚点 A，另一端向回扫（＝相反方向）
#   ⚠ 缩回**不要**改成「锚在相反一端」：那样扫动方向会跟生长相同（不是相反），2026-10-17 踩过。
#   ⚠ translation 沿世界轴（+x 向右 / +y 向上），不受 left_rotation 影响。
#
# 时间轴（刻 · 出生 = 1）：
#   1-4   四边框生长（3 刻）：上 左→右 / 右 上→下 / 下 右→左 / 左 下→上
#   4-6   YOU WIN 文字 0 → 100%（2 刻）
#   8-12  静止
#   12-16 四边框反向缩回（4 刻：右端向回扫 / 下端向回扫 / 左端向回扫 / 上端向回扫）
#         ＋ YOU WIN 文字缩回 0（2 刻，与放大对称）
#   21    全部删除

# ---- 段1（1-4）四边框生长：末状态 = 满态（满长 + 满态中心）----
#   youwin_top 上边框：轴 x，固定端锚点 [-6.3125f, 0.875f, 0.0f]（不动）→ 另一端扫到 [0.0f, 0.875f, 0.0f]
execute if score #youwin_wave youwin_t matches 1 as @e[tag=youwin_top] run data merge entity @s {start_interpolation: 0, interpolation_duration: 3, transformation: {scale: [12.625f, 0.8125f, 2.999999f], translation: [0.0f, 0.875f, 0.0f]}}
#   youwin_right 右边框：轴 y，固定端锚点 [1.1875f, 1.5625f, 0.0f]（不动）→ 另一端扫到 [1.1875f, 0.1875f, 0.0f]
execute if score #youwin_wave youwin_t matches 1 as @e[tag=youwin_right] run data merge entity @s {start_interpolation: 0, interpolation_duration: 3, transformation: {scale: [0.875f, 2.75f, 2.999999f], translation: [1.1875f, 0.1875f, 0.0f]}}
#   youwin_bottom 下边框：轴 x，固定端锚点 [6.3125f, 0.0f, 0.0f]（不动）→ 另一端扫到 [0.0f, 0.0f, 0.0f]
execute if score #youwin_wave youwin_t matches 1 as @e[tag=youwin_bottom] run data merge entity @s {start_interpolation: 0, interpolation_duration: 3, transformation: {scale: [12.625f, 0.8125f, 2.999999f], translation: [0.0f, 0.0f, 0.0f]}}
#   youwin_left 左边框：轴 y，固定端锚点 [-1.5f, -1.1875f, 0.0f]（不动）→ 另一端扫到 [-1.5f, 0.1875f, 0.0f]
execute if score #youwin_wave youwin_t matches 1 as @e[tag=youwin_left] run data merge entity @s {start_interpolation: 0, interpolation_duration: 3, transformation: {scale: [0.875f, 2.75f, 2.999999f], translation: [-1.5f, 0.1875f, 0.0f]}}

# ---- 段2（4-6）YOU WIN 文字 0 → 100% ----
#   ⚠ 文字与边框分开写：同一实体一刻只 merge 一次
execute if score #youwin_wave youwin_t matches 4 as @e[tag=youwin_text] run data merge entity @s {start_interpolation: 0, interpolation_duration: 2, transformation: {scale: [2.625f, 2.6875f, 2.999999f], translation: [0.0f, 0.0f, 0.0f]}}

# ---- 段3（12-16）四边框原路缩回（同锚点 A，另一端向回扫）＋ 文字缩回 0 ----
#   youwin_top 上边框：终点 = 长度 0 + 锚点 [-6.3125f, 0.875f, 0.0f]（与出生帧相同）→ 视觉上从另一端往回消失
execute if score #youwin_wave youwin_t matches 12 as @e[tag=youwin_top] run data merge entity @s {start_interpolation: 0, interpolation_duration: 4, transformation: {scale: [0.0f, 0.8125f, 2.999999f], translation: [-6.3125f, 0.875f, 0.0f]}}
#   youwin_right 右边框：终点 = 长度 0 + 锚点 [1.1875f, 1.5625f, 0.0f]（与出生帧相同）→ 视觉上从另一端往回消失
execute if score #youwin_wave youwin_t matches 12 as @e[tag=youwin_right] run data merge entity @s {start_interpolation: 0, interpolation_duration: 4, transformation: {scale: [0.875f, 0.0f, 2.999999f], translation: [1.1875f, 1.5625f, 0.0f]}}
#   youwin_bottom 下边框：终点 = 长度 0 + 锚点 [6.3125f, 0.0f, 0.0f]（与出生帧相同）→ 视觉上从另一端往回消失
execute if score #youwin_wave youwin_t matches 12 as @e[tag=youwin_bottom] run data merge entity @s {start_interpolation: 0, interpolation_duration: 4, transformation: {scale: [0.0f, 0.8125f, 2.999999f], translation: [6.3125f, 0.0f, 0.0f]}}
#   youwin_left 左边框：终点 = 长度 0 + 锚点 [-1.5f, -1.1875f, 0.0f]（与出生帧相同）→ 视觉上从另一端往回消失
execute if score #youwin_wave youwin_t matches 12 as @e[tag=youwin_left] run data merge entity @s {start_interpolation: 0, interpolation_duration: 4, transformation: {scale: [0.875f, 0.0f, 2.999999f], translation: [-1.5f, -1.1875f, 0.0f]}}
execute if score #youwin_wave youwin_t matches 12 as @e[tag=youwin_text] run data merge entity @s {start_interpolation: 0, interpolation_duration: 2, transformation: {scale: [0.0f, 0.0f, 0.0f], translation: [0.0f, 0.0f, 0.0f]}}
