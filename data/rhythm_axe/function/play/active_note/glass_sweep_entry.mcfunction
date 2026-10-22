# 玻璃扫掠宏入口（@s = 玻璃交互实体；glass_sweep 算好 #sw_d 后调用）
# 职责：把执行位置从「交互实体脚底」抬到「玻璃中心」，再沿朝向后退 d 格到扫掠段起点 P(T-2)。
#   at @s 提供交互实体位置 + Rotation（= 运动方向）；positioned ^ ^ ^ 沿该朝向后退。
# 之后交给 glass_sweep_step 字面量步进（上下文朝向跨函数保留）。
# 探针在交互实体上，展示实体完全不被触碰（其 NBT 每刻写会打断客户端插值）。
#arg: hs, d
$execute at @s positioned ~ ~$(hs) ~ positioned ^ ^ ^-$(d) run function rhythm_axe:play/active_note/glass_sweep_step
