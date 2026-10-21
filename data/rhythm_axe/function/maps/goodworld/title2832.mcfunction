# ========== title2832 开关（入口 · 出生）==========
# 出生当刻 = 第 0 刻（本文件出生）；驱动器 title2832_tick 每刻推一刻，第一刻 = #t2832_wave 1
# 关键帧下发在 title2832_frames，清理在 title2832_clear
# 时间轴（刻）：
#   1-52   静止不动（文字展示实体保持原位）
#   52-60  开始下移：整组（父实体 + 3 个乘客）向下平移 2 格（8 刻，三次缓入缓出）
#   60     到位 → 全部删除
#   ★ 2026-10-17：整条时间轴后移 32 刻（原本 1-20 静止 / 20-28 下移 / 28 删除）
#
# 实体（照抄原文件）：1 个不可见父实体（background 透明、text_opacity 0）+ 3 个乘客
#   t2832_root  父实体（不可见空容器，其 transformation 对乘客无影响）
#   t2832_name  「一只那起的核弹 / 二千二六」（scale 0.75，translation [-0.0625, 0.1875, -0.1875]）
#   t2832_glyph 「終」（scale 4，translation [0, 0.625, -0.1875]）
#   t2832_bar   「乂」横条（scale [4, 0.375, 4]，translation [0, 0.5625, -0.1875]）
# ★★ 改位移要**逐个写 3 个乘客**：乘客不继承父实体的 transformation（证据见 title2832_frames 顶部），
#   父实体的 scale.y = 6.6875 对乘客毫无作用，只动父实体 = 屏幕上什么都不会发生。
# ★ 位移用「第 20~28 刻逐刻一帧 + interpolation_duration:1」实现三次缓入缓出
#   （单帧 + duration=8 那种只能线性；曲线细节与逐刻值见 title2832_frames）
# ★ 本文件可重复执行：开头先清掉上一轮的残留实体与计时链
# 【手动试一次】/function rhythm_axe:maps/goodworld/title2832
# 【立刻收掉】  /function rhythm_axe:maps/goodworld/title2832_clear

scoreboard objectives add t2832_t dummy
kill @e[tag=t2832]
schedule clear rhythm_axe:maps/goodworld/title2832_tick

# 出生（第 0 刻）：父实体 + 3 个乘客；内容与几何照抄原文件，仅补 Tags 并改为单行书写
summon minecraft:text_display -1.5 0.5 0.5 {Passengers: [{alignment: "center", background: 0, default_background: 0b, id: "minecraft:text_display", line_width: 200, see_through: 0b, shadow: 0b, Tags: ["t2832", "t2832_name"], text: {bold: 1b, text: "一只那起的核弹\n二千二六"}, text_opacity: 255, transformation: {left_rotation: [0.0f, 1.0f, 0.0f, 0.0f], right_rotation: [0.0f, 0.0f, 0.0f, 1.0f], scale: [0.75f, 0.75f, 0.75f], translation: [-0.0625f, 0.1875f, -0.1875f]}}, {alignment: "center", background: 0, default_background: 0b, id: "minecraft:text_display", line_width: 200, see_through: 0b, shadow: 1b, Tags: ["t2832", "t2832_glyph"], text: {bold: 1b, text: "終"}, text_opacity: 255, transformation: {left_rotation: [0.0f, 1.0f, 0.0f, 0.0f], right_rotation: [0.0f, 0.0f, 0.0f, 1.0f], scale: [4.0f, 4.0f, 4.0f], translation: [0.0f, 0.625f, -0.1875f]}}, {alignment: "center", background: -1, default_background: 0b, id: "minecraft:text_display", line_width: 200, see_through: 1b, shadow: 0b, Tags: ["t2832", "t2832_bar"], text: "乂", text_opacity: 0b, transformation: {left_rotation: [0.0f, 1.0f, 0.0f, 0.0f], right_rotation: [0.0f, 0.0f, 0.0f, 1.0f], scale: [4.0f, 0.375f, 4.0f], translation: [0.0f, 0.5625f, -0.1875f]}}], alignment: "center", background: -2147483648, default_background: 0b, line_width: 200, see_through: 0b, shadow: 0b, Tags: ["t2832", "t2832_root"], text: "乂", text_opacity: 0b, transformation: {left_rotation: [0.0f, 1.0f, 0.0f, 0.0f], right_rotation: [0.0f, 0.0f, 0.0f, 1.0f], scale: [4.60215f, 6.6875f, 4.60215f], translation: [0.0f, 0.0f, 0.0f]}}

scoreboard players set #t2832_wave t2832_t 0
function rhythm_axe:maps/goodworld/title2832_frames
schedule function rhythm_axe:maps/goodworld/title2832_tick 1t