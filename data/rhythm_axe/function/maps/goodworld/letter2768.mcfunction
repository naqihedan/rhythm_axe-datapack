# ========== letter2768 信件收到动画（入口 · 出生）==========
# 出生当刻 = 第 1 刻；段关键帧在 letter2768_frames，驱动器 letter2768_tick 每刻推一刻
# 时间轴（刻）：
#   1-4   信封出现：整枚从几何中心散开 + 放大（缩放 0 → 100%）
#   4-8   左侧横线拉开（长度 0→满），偏移 3 → 0（屏幕上向右 3 格）
#   8-12  左侧横线静止 ／ 右侧横线拉开（长度 0→满），偏移 1.5 → 0（屏幕上向右 1.5 格）
#   9-12  信封上移 0.2 格
#   12-16 左侧横线收掉（长度 满→0），偏移 0 → -1.5（屏幕上向右）／ 信封下移 2 格
#   16-20 右侧横线收掉（长度 满→0），偏移 0 → -1.5（屏幕上向右，与左侧线同向）
#   21    全部删除（信封与横线一起消失）
#
# 实体：信封 = 父实体 letter2768_env_b + 5 个乘客（Passengers，共 6 个字块，出生时全部重合于锚点、缩放 0）；
#       横线 = letter2768_line_a（原第 2 条 summon，实体 x=1.0 ⇒ 屏幕上在左）/
#             letter2768_line_b（原第 3 条 summon，实体 x=-3.5 ⇒ 屏幕上在右）
# ★★ 屏幕右 = 世界 -X（玩家朝 +Z 时）⇒ translation.x 减小 = 屏幕上向右，增大 = 向左
# 全部打 tag letter2768；计时用计分项 letter2768_t（跑完自动 remove）
# ★ 本文件可重复执行：开头先清掉上一轮的残留实体与计时链
# ★ 动画是「逐段下一帧」而非逐刻一帧（原因见 frames 文件顶部），别改回去
# 【手动试一次】/function rhythm_axe:maps/goodworld/letter2768
# 【立刻收掉】  /function rhythm_axe:maps/goodworld/letter2768_clear

scoreboard objectives add letter2768_t dummy
kill @e[tag=letter2768]
schedule clear rhythm_axe:maps/goodworld/letter2768_tick

# 出生（第 1 刻）：6 块都重合在锚点、缩放 0；两条横线长度 0 且停在起始位置
summon minecraft:text_display -1.375 1.6875 0.5 {alignment: "center", background: -1593835521, default_background: 0b, line_width: 200, see_through: 0b, shadow: 0b, text: "乂", text_opacity: 0b, Tags: ["letter2768", "letter2768_env_b"], transformation: {left_rotation: [0.0f, 1.0f, 0.0f, 0.0f], right_rotation: [0.0f, 0.0f, 0.0f, 1.0f], scale: [0.0f, 0.0f, 0.0f], translation: [-0.0625f, -0.2696126f, 0.0f]}, Passengers: [{alignment: "center", background: -1593835521, default_background: 0b, id: "minecraft:text_display", line_width: 200, see_through: 0b, shadow: 0b, text: "乂", text_opacity: 0b, Tags: ["letter2768", "letter2768_env_p1"], transformation: {left_rotation: [0.2419219f, 0.9702957f, 0.0f, 0.0f], right_rotation: [0.0f, 0.0f, 0.0f, 1.0f], scale: [0.0f, 0.0f, 0.0f], translation: [-0.0625f, -0.2696126f, 0.0f]}}, {alignment: "center", background: -1593835521, default_background: 0b, id: "minecraft:text_display", line_width: 200, see_through: 0b, shadow: 0b, text: "乂", text_opacity: 0b, Tags: ["letter2768", "letter2768_env_p2"], transformation: {left_rotation: [0.7071068f, 0.7071068f, 0.0f, 0.0f], right_rotation: [0.0f, 0.0f, 0.0f, 1.0f], scale: [0.0f, 0.0f, 0.0f], translation: [-0.0625f, -0.2696126f, 0.0f]}}, {alignment: "center", background: -1593835521, default_background: 0b, id: "minecraft:text_display", line_width: 200, see_through: 0b, shadow: 0b, text: "乂", text_opacity: 0b, Tags: ["letter2768", "letter2768_env_p3"], transformation: {left_rotation: [-0.25881907f, 0.96592593f, 0.0f, 0.0f], right_rotation: [0.0f, 0.0f, 0.0f, 1.0f], scale: [0.0f, 0.0f, 0.0f], translation: [-0.0625f, -0.2696126f, 0.0f]}}, {alignment: "center", background: -1593835521, default_background: 0b, id: "minecraft:text_display", line_width: 200, see_through: 0b, shadow: 0b, text: "乂", text_opacity: 0b, Tags: ["letter2768", "letter2768_env_p4"], transformation: {left_rotation: [0.7071068f, 0.7071068f, 0.0f, 0.0f], right_rotation: [0.0f, 0.0f, 0.0f, 1.0f], scale: [0.0f, 0.0f, 0.0f], translation: [-0.0625f, -0.2696126f, 0.0f]}}, {alignment: "center", background: -1593835521, default_background: 0b, id: "minecraft:text_display", line_width: 200, see_through: 0b, shadow: 0b, text: "乂", text_opacity: 0b, Tags: ["letter2768", "letter2768_env_p5"], transformation: {left_rotation: [1.0f, 0.0f, 0.0f, 0.0f], right_rotation: [0.0f, 0.0f, 0.0f, 1.0f], scale: [0.0f, 0.0f, 0.0f], translation: [-0.0625f, -0.2696126f, 0.0f]}}]}
summon minecraft:text_display 1.0 1.3125 0.5 {alignment: "center", background: -1593835521, default_background: 0b, line_width: 200, see_through: 1b, shadow: 0b, text: "乂", text_opacity: 0b, Tags: ["letter2768", "letter2768_line_a"], transformation: {left_rotation: [0.0f, 1.0f, 0.0f, 0.0f], right_rotation: [0.0f, 0.0f, 0.0f, 1.0f], scale: [0.0f, 0.5f, 1.0f], translation: [3.0f, 0.0f, 0.0f]}}
summon minecraft:text_display -3.5 1.3125 0.5 {alignment: "center", background: -1593835521, default_background: 0b, line_width: 200, see_through: 0b, shadow: 0b, text: "乂", text_opacity: 0b, Tags: ["letter2768", "letter2768_line_b"], transformation: {left_rotation: [0.0f, 1.0f, 0.0f, 0.0f], right_rotation: [0.0f, 0.0f, 0.0f, 1.0f], scale: [0.0f, 0.5f, 1.0f], translation: [1.5f, 0.0f, 0.0f]}}

scoreboard players set #letter_wave letter2768_t 0
function rhythm_axe:maps/goodworld/letter2768_frames
schedule function rhythm_axe:maps/goodworld/letter2768_tick 1t
