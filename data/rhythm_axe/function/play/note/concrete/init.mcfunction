# 混凝土移动初始化（★ 2026-09-15 改为「一条曲线」模型）
# @s = 混凝土展示实体（summon 出生时调用；初始 NBT 已由 summon 设为 P0、scale.z=0）
#
# 【模型】头端与尾端沿**同一条轨迹**各走一次缓动 —— 尾端 = 头端延后 duration 刻
#   局部 z：+z = 运动方向、判定位置 = 0；出生点（长度 0）P0 = -d-s/2；头端终点 P1 = +s/2
#   Δ = d + s；lt' = note_c_lt（有效寿命）；m = note_c_m（duration）
#   t = lt' - life + 2（渲染延迟 2 刻）
#   u_h = clamp(t/lt', 0, 1)        → g  = E(u_h)
#   u_t = clamp((t-m)/lt', 0, 1)    → gt = E(u_t)
#   头端 = P0 + Δ·g ；尾端 = P0 + Δ·gt
#   长度 = Δ(g-gt) ；中心 = P0 + Δ(g+gt)/2
# 三段视觉（拉伸 → 平移/静止 → 收缩）与长 hold 的中间静止都是它的自然结果，不再分段各自套缓动。
#
# 【两套实现（数值一致）】
#   · 线性（power=1，默认）：客户端插值（summon 直接调 seg1_client → seg1_merge → seg2_client → seg3_client）
#     —— 保留插值是为了动作平滑 + 少写 NBT；本文件对线性音符不会被调用
#   · 非线性（power≠1）：不走 display_animation，改由 concrete/drive 每刻直接写 NBT（与编辑器 place_concrete 同一套公式）

function rhythm_axe:utilization/display_animation/reset_globals
scoreboard players set @s note_c_seg 1
# 非线性：确保 display_animation 不介入（drive 每刻直接写 NBT；初始 NBT 由 summon 设好）
scoreboard players set @s anim_status 0
