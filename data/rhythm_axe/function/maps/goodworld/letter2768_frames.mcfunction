# ========== letter2768 逐段关键帧（入口与驱动器都调用本函数）==========
# 时钟 #letter_wave letter2768_t → 出生当刻 = 1
#
# ★★ 本文件只在「每段开头」下发一帧，并给出该段时长（interpolation_duration）——
#    之后不再逐刻 merge。这是本数据包的正规做法（见 maps/goodworld/title2476_tick）：
#    · 展示实体每次数据同步都会把插值起点重置为当前刻；若每刻都 merge 一帧，
#      等于每刻从起点重插一次 ⇒ 画面反复抽搐（2026-10-17 踩过）。
#    · 一段只下一帧 + duration=段长 ⇒ 客户端自己线性插值，平滑无抖。
#    ⚠ 所以千万别把它改回「逐刻一帧」的写法。
#
# ★★ 屏幕坐标系（非常反直觉，务必记住）：
#   玩家朝 **+Z** 时，**屏幕右侧 = 世界 -X**（右手系：前=+Z、上=+Y ⇒ 右=-X）。
#   ⇒ **translation.x 增大 = 屏幕上向左；减小 = 屏幕上向右**（沿世界轴平移，不受 left_rotation 影响）。
#   ⇒ 想「向右收」就写更小的 x（本例 0 → -1.5）。
#   2026-10-17 因把它当成「+x = 向右」踩了两次坑。
#
# ★ 两条线的归属：
#   line_a（原第 2 条 summon，实体世界 x=1.0、偏移 3）→ 静止时世界中心 +4 ⇒ **屏幕上在左**
#   line_b（原第 3 条 summon，实体世界 x=-3.5、偏移 1.5）→ 静止时世界中心 -2 ⇒ **屏幕上在右**
#   ⚠ 所以「左边的线」= line_a，「右边的线」= line_b（按屏幕看，不是按世界坐标看）。
#
# 时间轴（刻 · 出生 = 1）：
#   1-4   信封出现：6 块从锚点（几何中心）散开 + 放大到满（duration 3）
#   4-8   左线（line_a）：长度 0→满 拉开，偏移 3 → 0（translation.x 减小 ⇒ 屏幕上向右 3 格，duration 4）
#   8-12  左线静止 ／ 右线（line_b）：长度 0→满 拉开，偏移 1.5 → 0（减小 ⇒ 屏幕上向右 1.5 格，duration 4）
#   9-12  信封上移 0.2（duration 3）
#   12-16 左线收掉（长度 满→0），偏移 0 → -1.5（减小 ⇒ 屏幕上向右 1.5 格）／ 信封下移 2（duration 4）
#   16-20 右线收掉（长度 满→0），偏移 0 → -1.5（减小 ⇒ 屏幕上向右 1.5 格，duration 4）
#
# ★ 线块的「中心」= transformation.translation.x（相对实体自身位置）；长度 = scale.x（满 = 16）
# ★ 只写 scale + translation —— 绝不写 left_rotation（写它会抹掉各块朝向）
# ★ 信封升降不用 tp（tp 不插值位置，会硬跳）—— 改为 6 块各写一次 translation

# ---- 段1（1-4）信封出现：6 块从锚点散开 + 放大（3 刻插值到原构图）----
execute if score #letter_wave letter2768_t matches 1 as @e[tag=letter2768_env_b] run data merge entity @s {interpolation_duration: 3, transformation: {scale: [5.0f, 0.5f, 1.0f], translation: [0.0f, 0.0f, 0.0f]}}
execute if score #letter_wave letter2768_t matches 1 as @e[tag=letter2768_env_p1] run data merge entity @s {interpolation_duration: 3, transformation: {scale: [2.75f, 0.4375001f, 1.0f], translation: [-0.25f, -0.25f, 0.0f]}}
execute if score #letter_wave letter2768_t matches 1 as @e[tag=letter2768_env_p2] run data merge entity @s {interpolation_duration: 3, transformation: {scale: [3.000001f, 0.5f, 1.0f], translation: [0.375f, -0.3088379f, 0.0f]}}
execute if score #letter_wave letter2768_t matches 1 as @e[tag=letter2768_env_p3] run data merge entity @s {interpolation_duration: 3, transformation: {scale: [2.375001f, 0.4375001f, 1.0f], translation: [0.25f, -0.1875f, 0.0f]}}
execute if score #letter_wave letter2768_t matches 1 as @e[tag=letter2768_env_p4] run data merge entity @s {interpolation_duration: 3, transformation: {scale: [3.000001f, 0.5f, 1.0f], translation: [-0.625f, -0.3088379f, 0.0f]}}
execute if score #letter_wave letter2768_t matches 1 as @e[tag=letter2768_env_p5] run data merge entity @s {interpolation_duration: 3, transformation: {scale: [5.0f, 0.5f, 1.0f], translation: [-0.125f, -0.5625f, 0.0f]}}

# ---- 段2（4-8）左线（line_a）拉开 + 偏移 3 → 0（屏幕上向右 3 格）----
execute if score #letter_wave letter2768_t matches 4 as @e[tag=letter2768_line_a] run data merge entity @s {interpolation_duration: 4, transformation: {scale: [16.0f, 0.5f, 1.0f], translation: [0.0f, 0.0f, 0.0f]}}

# ---- 段3（8-12）右线（line_b）拉开 + 偏移 1.5 → 0（屏幕上向右 1.5 格）----
execute if score #letter_wave letter2768_t matches 8 as @e[tag=letter2768_line_b] run data merge entity @s {interpolation_duration: 4, transformation: {scale: [16.0f, 0.5f, 1.0f], translation: [0.0f, 0.0f, 0.0f]}}

# ---- 段4（9-12）信封上移 0.2（3 刻）----
execute if score #letter_wave letter2768_t matches 9 as @e[tag=letter2768_env_b] run data merge entity @s {interpolation_duration: 3, transformation: {translation: [0.0f, 0.2f, 0.0f]}}
execute if score #letter_wave letter2768_t matches 9 as @e[tag=letter2768_env_p1] run data merge entity @s {interpolation_duration: 3, transformation: {translation: [-0.25f, -0.05f, 0.0f]}}
execute if score #letter_wave letter2768_t matches 9 as @e[tag=letter2768_env_p2] run data merge entity @s {interpolation_duration: 3, transformation: {translation: [0.375f, -0.1088379f, 0.0f]}}
execute if score #letter_wave letter2768_t matches 9 as @e[tag=letter2768_env_p3] run data merge entity @s {interpolation_duration: 3, transformation: {translation: [0.25f, 0.0125f, 0.0f]}}
execute if score #letter_wave letter2768_t matches 9 as @e[tag=letter2768_env_p4] run data merge entity @s {interpolation_duration: 3, transformation: {translation: [-0.625f, -0.1088379f, 0.0f]}}
execute if score #letter_wave letter2768_t matches 9 as @e[tag=letter2768_env_p5] run data merge entity @s {interpolation_duration: 3, transformation: {translation: [-0.125f, -0.3625f, 0.0f]}}

# ---- 段5（12-16）左线（line_a）收掉 + 偏移 0 → -1.5（屏幕上向右 1.5 格）----
execute if score #letter_wave letter2768_t matches 12 as @e[tag=letter2768_line_a] run data merge entity @s {interpolation_duration: 4, transformation: {scale: [0.0f, 0.5f, 1.0f], translation: [-1.5f, 0.0f, 0.0f]}}

# ---- 段6（12-16）信封下移 2（4 刻；起点 = 上移后的 +0.2，终点 = -1.8）----
execute if score #letter_wave letter2768_t matches 12 as @e[tag=letter2768_env_b] run data merge entity @s {interpolation_duration: 4, transformation: {translation: [0.0f, -1.8f, 0.0f]}}
execute if score #letter_wave letter2768_t matches 12 as @e[tag=letter2768_env_p1] run data merge entity @s {interpolation_duration: 4, transformation: {translation: [-0.25f, -2.05f, 0.0f]}}
execute if score #letter_wave letter2768_t matches 12 as @e[tag=letter2768_env_p2] run data merge entity @s {interpolation_duration: 4, transformation: {translation: [0.375f, -2.108838f, 0.0f]}}
execute if score #letter_wave letter2768_t matches 12 as @e[tag=letter2768_env_p3] run data merge entity @s {interpolation_duration: 4, transformation: {translation: [0.25f, -1.9875f, 0.0f]}}
execute if score #letter_wave letter2768_t matches 12 as @e[tag=letter2768_env_p4] run data merge entity @s {interpolation_duration: 4, transformation: {translation: [-0.625f, -2.108838f, 0.0f]}}
execute if score #letter_wave letter2768_t matches 12 as @e[tag=letter2768_env_p5] run data merge entity @s {interpolation_duration: 4, transformation: {translation: [-0.125f, -2.3625f, 0.0f]}}

# ---- 段7（16-20）右线（line_b）收掉 + 偏移 0 → -1.5（屏幕上向右 1.5 格，与左线同向）----
execute if score #letter_wave letter2768_t matches 16 as @e[tag=letter2768_line_b] run data merge entity @s {interpolation_duration: 4, transformation: {scale: [0.0f, 0.5f, 1.0f], translation: [-1.5f, 0.0f, 0.0f]}}
