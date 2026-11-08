# ========== title0045 标题视觉特效（入口 · 出生）==========
# 文件名数字 = 谱面里的事件触发刻数（**第 45 刻**触发本函数）。改触发刻要连文件名一起改。
# 整段时长 108 刻，即谱面第 45 → 152 刻。
# 内容 "MOBILYS"，7 个字各拆成一个独立 text_display（不用父+乘客：乘客的 transformation 不继承父实体，
#   改位置仍要逐个写，等于没省事）。
# 出生当刻 = 第 1 刻；逐刻关键帧在 title0045_frames，驱动器 title0045_tick 每刻推一刻，
#   第 108 刻整段结束 → 全部实体清理。
#
# 时间轴（刻）：
#   1       出生：7 字全部 text 为空（不可见），位置 = k1（原串原样）
#   1-12    字间距拉开 · 三次缓入缓出，整体缩放系数 k 从 1.0 → 1.5（走到总位移的 50%）
#   13-107  字间距继续拉开 · 线性，k 从 1.5 → 2.0（终点宽度 = 原串 2 倍）
#   108     全部实体删除
#   1-10    开头闪烁：每字 3 次闪烁（5 刻：亮灭亮灭亮），闪完停在亮（保持显示）
#           起点 M1 O2 B3 I4 L5 Y5 S6 —— 按阅读顺序递增（最左的 M 最先闪）
#   98-107  结尾闪烁：每字 3 次闪烁（5 刻：灭亮灭亮灭），闪完停在灭（永久隐藏）
#           起点 M98 O99 B100 I101 L102 Y102 S103
#           ★ 先闪完的先隐藏（各字起点不同，不是同一刻集体闪）
#           ★ ⚠ 开头窗口 1..6 只有 6 个起点却有 7 个字 ⇒ 必然有一对完全同步；
#             本实现让 **L 与 Y** 共用起点（同色系，观感最不明显）。
#             若要全部错开，把开头范围放宽到 1..8（结尾放宽到 96..103）即可。
#
# ★★ 拆字后为什么间距要按「字形中心」算（而不是简单等分）：
#   默认字体**不等宽**——从 ascii.png 逐像素量出实际字形宽 / advance：
#     M 5/6 · O 5/6 · B 3/4 · I 3/4 · L 1/2 · Y 5/6 · S 5/6
#   7 字 advance 累计 34px，字形中心依次落在 3, 9, 14, 18, 21, 25, 31 px。
#   锚点取 I 的中心 18px ⇒ 各国相对 I 的偏移 = (中心 − 18) × 0.025 × 1.75 世界格。
#   1px = 0.025 格（Font 层）再乘 scale 1.75 ⇒ 0.04375 格/px。
#
# ★★ 左右方向（yaw=180 时）：实体 Rotation yaw=180 ⇒ calculateOrientation 做 rotationY(−π)，
#   把局部 +X 映射到世界 −X。玩家站在标题 −Z 侧朝 +Z 看时，屏幕右 = 世界 −X = **局部 +X**
#   ⇒ translation.x 增大 = 屏幕上向右。故 M（串首、屏幕最左）取负值，S（串尾、最右）取正值。
#   ※ 交叉验证：title_youwin 用同一套 Rotation[180,0] + translation.x 判方向，符号体系一致。
#
# ★ 闪烁用「text 置空 / 还原完整 component」硬切，**不用 text_opacity**：
#   text（Component）不参与插值，改它当刻瞬变；transformation 仍走逐刻插值，互不干扰。
#   （若用 text_opacity 会跟 transformation 共享同一条 interpolationProgress 时间线，
#     闪烁会被抹成渐变，且打断位移插值。）
# ★ 位置缓动段逐刻一帧（duration:1）；线性段只在第 13 刻下发一次 duration:94，
#   客户端自己插值到第 107 刻。段中若补写 transformation 会重启插值 ⇒ 抽搐。
# ★ 本文件可重复执行：开头先清掉上一轮的残留实体与计时链
# 【手动试一次】/function rhythm_axe:maps/mobilys/title0045
# 【立刻收掉】  /function rhythm_axe:maps/mobilys/title0045_clear

scoreboard objectives add t0045_t dummy
kill @e[tag=t0045]
schedule clear rhythm_axe:maps/mobilys/title0045_tick

# 出生（第 1 刻）：7 个实体，text 全为空（不可见），位置 = k1 原串布局

summon minecraft:text_display -1.5 1.1875 0.5 {Rotation: [180.0f, 0.0f], alignment: "center", background: 0, default_background: 0b, line_width: 200, see_through: 0b, shadow: 1b, text: "", Tags: ["t0045", "t0045_m"], text_opacity: 255, transformation: {left_rotation: [0.0f, 0.0f, 0.0f, 1.0f], right_rotation: [0.0f, 0.0f, 0.0f, 1.0f], scale: [1.75f, 1.75f, 1.75f], translation: [-0.65625f, 0.0f, 0.0f]}}
summon minecraft:text_display -1.5 1.1875 0.5 {Rotation: [180.0f, 0.0f], alignment: "center", background: 0, default_background: 0b, line_width: 200, see_through: 0b, shadow: 1b, text: "", Tags: ["t0045", "t0045_o"], text_opacity: 255, transformation: {left_rotation: [0.0f, 0.0f, 0.0f, 1.0f], right_rotation: [0.0f, 0.0f, 0.0f, 1.0f], scale: [1.75f, 1.75f, 1.75f], translation: [-0.39375f, 0.0f, 0.0f]}}
summon minecraft:text_display -1.5 1.1875 0.5 {Rotation: [180.0f, 0.0f], alignment: "center", background: 0, default_background: 0b, line_width: 200, see_through: 0b, shadow: 1b, text: "", Tags: ["t0045", "t0045_b"], text_opacity: 255, transformation: {left_rotation: [0.0f, 0.0f, 0.0f, 1.0f], right_rotation: [0.0f, 0.0f, 0.0f, 1.0f], scale: [1.75f, 1.75f, 1.75f], translation: [-0.175f, 0.0f, 0.0f]}}
summon minecraft:text_display -1.5 1.1875 0.5 {Rotation: [180.0f, 0.0f], alignment: "center", background: 0, default_background: 0b, line_width: 200, see_through: 0b, shadow: 1b, text: "", Tags: ["t0045", "t0045_i"], text_opacity: 255, transformation: {left_rotation: [0.0f, 0.0f, 0.0f, 1.0f], right_rotation: [0.0f, 0.0f, 0.0f, 1.0f], scale: [1.75f, 1.75f, 1.75f], translation: [0.0f, 0.0f, 0.0f]}}
summon minecraft:text_display -1.5 1.1875 0.5 {Rotation: [180.0f, 0.0f], alignment: "center", background: 0, default_background: 0b, line_width: 200, see_through: 0b, shadow: 1b, text: "", Tags: ["t0045", "t0045_l"], text_opacity: 255, transformation: {left_rotation: [0.0f, 0.0f, 0.0f, 1.0f], right_rotation: [0.0f, 0.0f, 0.0f, 1.0f], scale: [1.75f, 1.75f, 1.75f], translation: [0.13125f, 0.0f, 0.0f]}}
summon minecraft:text_display -1.5 1.1875 0.5 {Rotation: [180.0f, 0.0f], alignment: "center", background: 0, default_background: 0b, line_width: 200, see_through: 0b, shadow: 1b, text: "", Tags: ["t0045", "t0045_y"], text_opacity: 255, transformation: {left_rotation: [0.0f, 0.0f, 0.0f, 1.0f], right_rotation: [0.0f, 0.0f, 0.0f, 1.0f], scale: [1.75f, 1.75f, 1.75f], translation: [0.30625f, 0.0f, 0.0f]}}
summon minecraft:text_display -1.5 1.1875 0.5 {Rotation: [180.0f, 0.0f], alignment: "center", background: 0, default_background: 0b, line_width: 200, see_through: 0b, shadow: 1b, text: "", Tags: ["t0045", "t0045_s"], text_opacity: 255, transformation: {left_rotation: [0.0f, 0.0f, 0.0f, 1.0f], right_rotation: [0.0f, 0.0f, 0.0f, 1.0f], scale: [1.75f, 1.75f, 1.75f], translation: [0.56875f, 0.0f, 0.0f]}}

scoreboard players set #t0045_wave t0045_t 0
function rhythm_axe:maps/mobilys/title0045_frames
schedule function rhythm_axe:maps/mobilys/title0045_tick 1t
