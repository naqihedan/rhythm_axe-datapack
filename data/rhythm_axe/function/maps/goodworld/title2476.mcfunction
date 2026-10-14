# ========== title2476 开关（入口）==========
# 以出生为第 0 刻：
#   2 隐藏 → 4 显示 → 6 隐藏 → 8 显示并开始缩小（scale 4.5 → 2.5、平移 -1.08 → -0.6，28 刻线性）→ 36 删除
# ★ 隐藏/显示用 scale=0 / scale=4.5 瞬切（interpolation_duration:0）
#   —— text_opacity 做不到：4~26 会被游戏丢弃、0~3 又当 255，靠透明度藏不住
# ⚠️ 本文件可安全重复执行：开头先清掉上一轮遗留的实体与计时链
# ⚠️ 计分项 t2476_t 由本文件 add、驱动器跑完 remove；跑完自动清干净

# 计分项（本套专用）
scoreboard objectives add t2476_t dummy

# 防重复触发：清残留实体 + 取消上一轮计时链
kill @e[tag=t2476]
schedule clear rhythm_axe:maps/goodworld/title2476_tick

# 第 0 刻：出生（scale 4.5，红字两列）
summon minecraft:text_display -1.5 1.5 0.5 {alignment: "center", background: 0, default_background: 0b, line_width: 200, see_through: 0b, shadow: 0b, text: {color: "red", text: "開   反\n始   擊"}, text_opacity: 96b, Tags: ["t2476"], transformation: {left_rotation: [0.0f, 1.0f, 0.0f, 0.0f], right_rotation: [0.0f, 0.0f, 0.0f, 1.0f], scale: [4.5f, 4.5f, 4.5f], translation: [0.0f, -1.08f, 0.0f]}}

# 绝对时钟归零 → 排驱动器
scoreboard players set #t2476_wave t2476_t 0
schedule function rhythm_axe:maps/goodworld/title2476_tick 1t
