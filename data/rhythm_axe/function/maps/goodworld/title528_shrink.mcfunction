# 528 标题展示实体：出生后 2 刻接管，56 刻内缓慢缩小到 90%（与 title80_ 同款手法）
# ★ 必须晚于召唤 ≥1 刻下发（各阶段用 schedule … 2t 调本函数），否则客户端还没渲染出生状态、插值没有起点
# ★ 每个阶段（64 刻）都会重新 summon ⇒ 新实体重新从满尺寸缩一次，从头缩到尾
# ★ 只 merge transformation.scale（递归合并，left_rotation/translation 不受影响）；插值在客户端跑，服务端零每刻开销
# 想改幅度：把下面三个 scale 换成「原始 scale × 系数」（现在是 0.90）
execute as @e[tag=background] run data merge entity @s {transformation:{scale:[7.0875f,5.847f,1.0f]},interpolation_duration:56,start_interpolation:0}
execute as @e[tag=title] run data merge entity @s {transformation:{scale:[2.7f,2.25f,1.0f]},interpolation_duration:56,start_interpolation:0}
execute as @e[tag=subtitle] run data merge entity @s {transformation:{scale:[1.3613f,1.08f,1.0f]},interpolation_duration:56,start_interpolation:0}
