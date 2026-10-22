# 玻璃扫掠单采样点（glass_sweep_entry 注入起点后递归；执行位置 = 当前采样点）
# ★ 2026-10-21 去 marker 重写：不再移动 marker Pos（0 次 NBT 写）——
#   检测直接在当前执行位置做，之后 positioned ^ ^ ^1 沿运动方向后退 1 格（字面量，上下文朝向保留）。
# 对角区域检测 = "玻璃中心 0.5³ 方块 ∩ 玩家判定箱"（与旧版同款几何）：
#   引擎里 dx=0 实际是「从该点起 1 格宽」的判定体，两点取交集后有效范围 = 玩家箱 ±(两点间距/2)：
#   −0.75/+0.5（间距 0.5）→ ±0.50 格（XZ 有效宽 0.6+0.5=1.1 > 步长 1.0 → 相邻覆盖区重叠，不隧穿）。
# 命中 → judgement_feedback/damage（@s 仍是玻璃展示实体；damage 内部按 note_id 配对交互实体做反馈，
#   音效/粒子以交互实体位置播放——与旧版语义一致）。
# 终止：#sw_i（×100）+100 > #sw_d（×100）即停（含起点与终点两端；d=0 时只测起点单点）。

# 对角区域点检测（命中 → damage）
execute positioned ~-0.75 ~-0.75 ~-0.75 if entity @a[team=player,dx=0,dy=0,dz=0] positioned ~0.5 ~0.5 ~0.5 if entity @a[team=player,dx=0,dy=0,dz=0] run function rhythm_axe:play/judgement_feedback/damage
# 游标 +100（×100 尺度 = 1 格），未超段长则后退 1 格继续（i ≤ d）
scoreboard players add #sw_i play_state 100
execute if score #sw_i play_state <= #sw_d play_state positioned ^ ^ ^1 run function rhythm_axe:play/active_note/glass_sweep_step
