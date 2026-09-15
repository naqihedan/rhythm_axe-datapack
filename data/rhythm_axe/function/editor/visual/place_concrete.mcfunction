# 混凝土（3）定位：★ 2026-09-15 改为「一条曲线」模型（替代原「三段各自套一次缓动」）
# @s = 编辑器音符展示实体（place.mcfunction 调用；本函数直接写 translation/scale）
#
# 【模型】头端与尾端沿**同一条轨迹**各走一次缓动 —— 尾端 = 头端的轨迹延后 duration 刻
#   局部 z：+z = 运动方向、判定位置 = 0；出生点（长度 0 处）P0 = -s/2-d；头端终点 P1 = s/2
#   Δ = P1 - P0 = d + s（头端 / 尾端各自的行程）
#   u_h = clamp((播放头 - birth) / 有效寿命, 0, 1)          → g  = E(u_h)
#   u_t = clamp((播放头 - birth - duration) / 有效寿命, 0, 1) → gt = E(u_t)
#   头端 = P0 + Δ·g ；尾端 = P0 + Δ·gt
#   长度 = 头端 - 尾端 = Δ(g-gt) ；中心 = (头端+尾端)/2 = P0 + Δ(g+gt)/2
#
# 【三段视觉是自然结果，不再分段套缓动】
#   · 播放头 < birth+duration  ：gt 恒 0（尾端钉在出生点）→ 只有头端动 = 拉伸
#   · 播放头 ≥ birth+有效寿命  ：g  恒 1（头端钉在终点）  → 只有尾端动 = 收缩
#   · 长 hold（duration > 有效寿命）时上面两个条件之间夹一段「头尾都不动」= 整条静止
#
# 【与旧实现的关系】
#   · 长 hold：**完全等价**（旧实现本来就是「头走一条曲线、尾走一条曲线」）
#   · 短 hold：旧实现把头的运动在 birth+duration 处切成两段、每段各套一次缓动
#     → 缓入缓出/缓入/缓出都会「缓动 2~3 次」，现已消除（全段只有一次缓动）
#
# 输出：translation[2]（中心）、scale[2]（长度）；place.mcfunction 之后据此换算交互实体头端
# 依赖实体计分板：editor_n_birth/time/dist/dur/size/easing/power；并覆盖 editor_n_lt = 有效寿命
# ★ #half_sz（size/2×100）必须保留：place.mcfunction 之后还要用它算交互实体偏移

# ---- 常量 ----
scoreboard players operation #half_sz editor = @s editor_n_size
scoreboard players operation #half_sz editor /= 20 const
# 有效寿命 = time - birth（已含流速缩放）→ 覆写 editor_n_lt，之后一律按有效寿命走
scoreboard players operation #life editor = @s editor_n_time
scoreboard players operation #life editor -= @s editor_n_birth
execute if score #life editor matches ..0 run scoreboard players set #life editor 1
scoreboard players operation @s editor_n_lt = #life editor
# P0 = -s/2 - d（出生点）
scoreboard players operation #P0 editor = #half_sz editor
scoreboard players operation #P0 editor *= -1 const
scoreboard players operation #P0 editor -= @s editor_n_dist
# Δ = d + s = d + 2×(s/2)
scoreboard players operation #dtot editor = @s editor_n_dist
scoreboard players operation #dtot editor += #half_sz editor
scoreboard players operation #dtot editor += #half_sz editor

# ---- 头端缓动进度 g（0~10000）----
scoreboard players operation #n display_calc = #playhead editor
scoreboard players operation #n display_calc -= @s editor_n_birth
execute if score #n display_calc matches ..0 run scoreboard players set #n display_calc 0
scoreboard players operation #total display_calc = @s editor_n_lt
execute if score #total display_calc matches ..0 run scoreboard players set #total display_calc 1
execute if score #n display_calc > #total display_calc run scoreboard players operation #n display_calc = #total display_calc
scoreboard players operation #power display_calc = @s editor_n_power
scoreboard players operation #easing_type display_calc = @s editor_n_easing
function rhythm_axe:utilization/display_animation/easing/power
scoreboard players operation #g editor = #ratio display_calc

# ---- 尾端缓动进度 gt（同一条曲线，延后 duration 刻）----
scoreboard players operation #n display_calc = #playhead editor
scoreboard players operation #n display_calc -= @s editor_n_birth
scoreboard players operation #n display_calc -= @s editor_n_dur
execute if score #n display_calc matches ..0 run scoreboard players set #n display_calc 0
execute if score #n display_calc > #total display_calc run scoreboard players operation #n display_calc = #total display_calc
function rhythm_axe:utilization/display_animation/easing/power
scoreboard players operation #gt editor = #ratio display_calc

# ---- 长度（×100）= Δ×(g-gt)/10000 ----
scoreboard players operation #len100 editor = #g editor
scoreboard players operation #len100 editor -= #gt editor
scoreboard players operation #len100 editor *= #dtot editor
scoreboard players operation #len100 editor /= 10000 const
execute if score #len100 editor matches ..0 run scoreboard players set #len100 editor 0
# ---- 中心（×100）= P0 + Δ×(g+gt)/20000 ----
scoreboard players operation #TZ editor = #g editor
scoreboard players operation #TZ editor += #gt editor
scoreboard players operation #TZ editor *= #dtot editor
scoreboard players operation #TZ editor /= 20000 const
scoreboard players operation #TZ editor += #P0 editor

# ---- 写 NBT（平移只动 z；scale[0/1] 由 fill_disp 负责）----
data modify entity @s transformation.translation set value [0.0,0.0,0.0]
execute store result entity @s transformation.scale[2] float 0.01 run scoreboard players get #len100 editor
execute store result entity @s transformation.translation[2] float 0.01 run scoreboard players get #TZ editor

# ---- 段标记（仅供调试输出：1=拉伸 / 2=平移或静止 / 3=收缩）----
scoreboard players set #seg editor 1
scoreboard players operation #tmp editor = @s editor_n_birth
scoreboard players operation #tmp editor += @s editor_n_dur
execute if score #playhead editor > #tmp editor run scoreboard players set #seg editor 2
scoreboard players operation #tmp editor = @s editor_n_birth
scoreboard players operation #tmp editor += @s editor_n_lt
execute if score #playhead editor >= #tmp editor run scoreboard players set #seg editor 3
