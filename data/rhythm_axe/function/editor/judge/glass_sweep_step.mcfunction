# 玻璃扫掠单采样点（glass_sweep_entry 注入起点后递归；执行位置 = 当前采样点）
# 每点：对角两点检测（= 玻璃中心 0.5³ 方块 ∩ 玩家判定箱）→ 命中则 glass_feedback →
#   未命中则 positioned ^ ^ ^1 沿运动方向前进 1 格继续（上下文朝向跨函数保留）。
# ★ 交互实体零触碰（旧版借其 Pos 承载采样点，循环后位置不归还 → 判定箱丢 Y 偏移）。
# 对角两点检测几何：两点相距 0.5 ⇒ 有效范围 ±0.50 格（XZ 宽 0.6+0.5=1.1 > 步长 1.0 ⇒ 相邻覆盖重叠，不隧穿）
# @s 仍是玻璃展示实体（glass_feedback 要用它读 hitsound/粒子组与 note_id）

# 对角两点检测：命中 → 跳 damage 组反馈（#ed_g_hit=1 后本刻不再采样）
# ★ 冷却中（#ed_g_cd > 0，玩家级）不重复反馈；用 unless「matches 1..」⇒ 未赋值 / 为 0 都放行
execute positioned ~-0.75 ~-0.75 ~-0.75 if entity @a[tag=editor_active,dx=0,dy=0,dz=0] positioned ~0.5 ~0.5 ~0.5 if entity @a[tag=editor_active,dx=0,dy=0,dz=0] unless score #ed_g_cd editor matches 1.. run function rhythm_axe:editor/visual/glass_feedback with storage rhythm_axe:editor.runtime

# 游标推进（i ≤ d 时沿运动方向前进 1 格继续；命中（#ed_g_hit=1）或超段长即停）
scoreboard players add #gsc_i editor 100
execute if score #ed_g_hit editor matches 0 if score #gsc_i editor <= #gsc_d editor positioned ^ ^ ^1 run function rhythm_axe:editor/judge/glass_sweep_step
