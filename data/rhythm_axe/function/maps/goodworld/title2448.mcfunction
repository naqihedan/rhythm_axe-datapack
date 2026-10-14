# ========== title2448 开关（入口）==========
# 执行一次 → 开启 28 刻演出：
#   0-8 ：只有「攻」字，scale 4.5 → 3.0625（三次方缓出，8 刻）
#   8-18：六条边每 2 刻出生一条（第 8/10/12/14/16/18 刻）
#         每条 summon 在「目标位」、translation 从「再往外 1 格」（目标 ×3.5）开始，向内平移 1 格（6 刻，三次方缓出）
#   24-28：六条边同时向外扩散 1 格（回到出生位），三次方缓入
#   28  ：全部删除
# ★ 缓动不用展示实体动画系统：它每步会把「不参与动画的旋转」写成单位四元数（会把边/字的朝向抹掉）。
#   改用「每刻一个关键帧」（每帧只插值 1 刻）⇒ 等价精确的缓出曲线（与 title500 / goodfx 波次同一套做法）。
# ⚠️ 本文件可安全重复执行：开头会先清掉上一轮遗留的实体与计时（否则重复触发会「多几条边」）
# ⚠️ 计分项 t2448_t 由本文件 add、驱动器跑完 remove（不依赖 load.mcfunction）；跑完全部自动清干净

# 计分项（本套专用）
scoreboard objectives add t2448_t dummy

# ★ 防重复触发：清掉上一轮遗留的实体 + 取消上一轮还没跑完的计时链
#   （否则重复执行入口时：旧边还在天上 + 新旧两条计时链同时推进 ⇒ 六条边会变成「多几条」）
kill @e[tag=t2448]
schedule clear rhythm_axe:maps/goodworld/title2448_tick

# 第 0 刻：出生「攻」（起点 scale 4.5）
summon minecraft:text_display -1.5 1.4375 0.5 {alignment: "center", background: 0, default_background: 0b, line_width: 200, see_through: 0b, shadow: 0b, text: "攻", text_opacity: 64, Tags: ["t2448", "t2448_gong"], transformation: {left_rotation: [0.0f, 1.0f, 0.0f, 0.0f], right_rotation: [0.0f, 0.0f, 0.0f, 1.0f], scale: [4.5f, 4.5f, 4.5f], translation: [0.0f, -0.375f, 0.0f]}}

# 绝对时钟归零 → 排驱动器（上面已 clear，保证任何时刻只有一条计时链）
scoreboard players set #t2448_wave t2448_t 0
schedule function rhythm_axe:maps/goodworld/title2448_tick 1t