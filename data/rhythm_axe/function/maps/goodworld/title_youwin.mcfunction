# ========== title_youwin 开关（入口 · 出生）==========
# 出生当刻 = 第 1 刻；段关键帧在 title_youwin_frames，驱动器 title_youwin_tick 每刻推一刻
# ★ 只有 YOU WIN 文字用 2 刻（放大 4-6、缩回 12-14）；四条边框仍用 3 / 4 刻（1-4 生长、12-16 缩回）
# 时间轴（刻）：
#   1-4   四边框各自生长（3 刻）：上从左到右 / 右从上到下 / 下从右到左 / 左从下往上
#   4-6   YOU WIN 文字缩放 0 到 100%（2 刻）
#   8-12  静止
#   12-16 四边框反向缩回（4 刻）＋ YOU WIN 文字缩回 0（2 刻，12-14）
#   21    全部删除
#
# 原文件是一条 summon + 3 个乘客（外框 2 个乘客 + 1 个文字乘客 + 父实体）。
# ★ 现按要求把乘客拆成独立实体（共 5 个）——理由有两个：
#   ① 父实体的 transformation 会「叠加」给乘客，拆开后才好让四条边框各自独立缩放；
#   ② 乘客只能靠父实体合并被数据修改，逐段关键帧写起来很别扭。
# 各实体的出生位置/朝向/满态几何 完全照抄原文件（长条中心 = 实体位置 + translation）：
#   youwin_top    上边框  scale [12.625, 0.8125, 2.999999]  translation [0, 0.875, 0]
#   youwin_right  右边框  scale [0.875, 2.75, 2.999999]     translation [1.1875, 0.1875, 0]
#   youwin_bottom 下边框  scale [12.625, 0.8125, 2.999999]  translation [0, 0, 0]
#   youwin_left   左边框  scale [0.875, 2.75, 2.999999]     translation [-1.5, 0.1875, 0]
#   youwin_text   YOU WIN scale [2.625, 2.6875, 2.999999]   translation [0, 0, 0]
# ★ 出生时 5 个实体的 scale 全为 0（不可见）；四边框的 translation 已按各自生长方向
#   锚到「生长起始端」（= 满态中心 + 符号×半长），见 frames 文件顶部说明。
# ★ 本文件可重复执行：开头先清掉上一轮的残留实体与计时链
# 【手动试一次】/function rhythm_axe:maps/goodworld/title_youwin
# 【立刻收掉】  /function rhythm_axe:maps/goodworld/title_youwin_clear

scoreboard objectives add youwin_t dummy
kill @e[tag=youwin]
schedule clear rhythm_axe:maps/goodworld/title_youwin_tick

# 出生（第 1 刻）：四边框 + 文字，全部 scale 0、平移到各自的生长起点
summon minecraft:text_display -1.375 0.9375 0.25 {alignment: "center", background: -2130706433, default_background: 0b, line_width: 200, see_through: 0b, shadow: 0b, text: "乂", text_opacity: 0b, Tags: ["youwin", "youwin_top"], transformation: {left_rotation: [0.0f, 1.0f, 0.0f, 0.0f], right_rotation: [0.0f, 0.0f, 0.0f, 1.0f], scale: [0.0f, 0.0f, 0.0f], translation: [-6.3125f, 0.875f, 0.0f]}}
summon minecraft:text_display -1.375 0.9375 0.25 {alignment: "center", background: -2130706433, default_background: 0b, line_width: 200, see_through: 0b, shadow: 0b, text: "乂", text_opacity: 0b, Tags: ["youwin", "youwin_right"], transformation: {left_rotation: [0.0f, 1.0f, 0.0f, 0.0f], right_rotation: [0.0f, 0.0f, 0.0f, 1.0f], scale: [0.0f, 0.0f, 0.0f], translation: [1.1875f, 1.5625f, 0.0f]}}
summon minecraft:text_display -1.375 0.9375 0.25 {alignment: "center", background: -2130706433, default_background: 0b, line_width: 200, see_through: 0b, shadow: 0b, text: "乂", text_opacity: 0b, Tags: ["youwin", "youwin_bottom"], transformation: {left_rotation: [0.0f, 1.0f, 0.0f, 0.0f], right_rotation: [0.0f, 0.0f, 0.0f, 1.0f], scale: [0.0f, 0.0f, 0.0f], translation: [6.3125f, 0.0f, 0.0f]}}
summon minecraft:text_display -1.375 0.9375 0.25 {alignment: "center", background: -2130706433, default_background: 0b, line_width: 200, see_through: 0b, shadow: 0b, text: "乂", text_opacity: 0b, Tags: ["youwin", "youwin_left"], transformation: {left_rotation: [0.0f, 1.0f, 0.0f, 0.0f], right_rotation: [0.0f, 0.0f, 0.0f, 1.0f], scale: [0.0f, 0.0f, 0.0f], translation: [-1.5f, -1.1875f, 0.0f]}}
summon minecraft:text_display -1.5 1.125 0.25 {alignment: "center", background: 1073741824, default_background: 0b, line_width: 200, see_through: 1b, shadow: 0b, text: "YOU WIN", text_opacity: 128, Tags: ["youwin", "youwin_text"], transformation: {left_rotation: [0.0f, 1.0f, 0.0f, 0.0f], right_rotation: [0.0f, 0.0f, 0.0f, 1.0f], scale: [0.0f, 0.0f, 0.0f], translation: [0.0f, 0.0f, 0.0f]}}

scoreboard players set #youwin_wave youwin_t 0
function rhythm_axe:maps/goodworld/title_youwin_frames
schedule function rhythm_axe:maps/goodworld/title_youwin_tick 1t
