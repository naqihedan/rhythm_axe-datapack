# 编辑器玻璃扫掠宏入口（@s = 玻璃展示实体；glass_check 算好 #gsc_tzs/#gsc_d/#gsc_i 后调用）
# 唯一职责：把起点局部 z（×100 → double 0.01）宏注入 positioned ^ ^ ^$(tz_start)，
#   使执行位置 = 扫掠段起点 P(T-1)（沿展示实体 Rotation = 运动方向后退 |tz_start| 格）。
# 之后交给 glass_sweep_step 字面量步进（上下文朝向跨函数保留）。
# ★ 交互实体自始至终不被触碰（对比旧版借其 Pos 承载采样点）。
#arg: tz_start
$execute at @s positioned ^ ^ ^$(tz_start) run function rhythm_axe:editor/judge/glass_sweep_step