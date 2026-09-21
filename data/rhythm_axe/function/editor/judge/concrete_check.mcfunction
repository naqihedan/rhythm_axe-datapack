# ★ 水平距离判定用 `matches 1000001..` 而非 `> 1000000` —— if score 右侧不支持裸常量（写了会整函数不加载）
# 编辑器真实判定：混凝土（@s = 混凝土展示实体；at @s 由 tick_one 保证）
# 照搬游玩 judgement/main_concrete 语义：分段 + 判定区域 + 保护1/2。编辑器不扣血、不计成绩，只播反馈。
# 与游玩的两点实现差异：
#   ① 判定位置/朝向用展示实体自身（Pos 恒 = 判定位置、Rotation.yaw = 运动方向）——
#      检测前 at @s + rotated ~ 0 把 pitch 归零（★ 2026-09-21 起游玩侧也改成同一写法，note_c_zone marker 已删）
#   ② 段进度不用实体状态机，而是「已判完段数」editor_n_c_last 每刻现算推进 ⇒ 天然抵抗 seek / 跳转
# 段模型（d = density，x = judgement_scale）：
#   段 k（1..seg_count）覆盖寿命 life ∈ [-(k-1)·d, -min(k·d, dur)]
#   · 段内任意刻「玩家在判定区域」→ 该段立即大P
#   · 段末仍不在区域 → 该段 miss（不中断后续段）
#   · 保护1（首段过早离开）：life ∈ [1,3x] 在区域内 → 记录寿命；首段段末不在区域但有记录 → 按记录寿命判级
#   · 保护2（末段过短）：末段长 < 3x → 延长 3x，延长窗口内按 level(life + dur) 判级；窗口结束仍未判 → miss
# 前置：#playhead、#ed_scale；@s editor_n_time / dur / density / seg_count / rec_life / c_last

# ===== 1) 寿命 / 3x / 末段长 / 延长量 / 有效下界 =====
scoreboard players operation #ct_life editor = @s editor_n_time
scoreboard players operation #ct_life editor -= #playhead editor
scoreboard players operation #ct_x3 editor = #ed_scale editor
scoreboard players operation #ct_x3 editor *= 3 const
scoreboard players operation #ct_ll editor = @s editor_n_seg_count
scoreboard players remove #ct_ll editor 1
scoreboard players operation #ct_ll editor *= @s editor_n_density
scoreboard players operation #ct_ll editor *= -1 const
scoreboard players operation #ct_ll editor += @s editor_n_dur
execute if score #ct_ll editor matches ..0 run scoreboard players operation #ct_ll editor = @s editor_n_density
scoreboard players set #ct_ext editor 0
execute if score #ct_ll editor < #ct_x3 editor run scoreboard players operation #ct_ext editor = #ct_x3 editor
scoreboard players operation #ct_neg editor = @s editor_n_dur
scoreboard players operation #ct_neg editor += #ct_ext editor
scoreboard players operation #ct_neg editor *= -1 const

# ===== 2) 判定区域检测（#ct_in）=====
scoreboard players set #ct_in editor 0
# 没有编辑者 → 区域恒空（直接不判，省掉 marker/选择器开销）
execute unless entity @a[tag=editor_active] run return 0
# 水平距离²（×1e6）= (start_x − position_x)² + (start_z − position_z)² ⇒ 与 1e6 比较 = 「水平距离 > 1 格」
scoreboard players operation #ct_hx editor = @s editor_n_sx
scoreboard players operation #ct_hx editor -= @s editor_n_px
scoreboard players operation #ct_hz editor = @s editor_n_sz
scoreboard players operation #ct_hz editor -= @s editor_n_pz
scoreboard players operation #ct_h2 editor = #ct_hx editor
scoreboard players operation #ct_h2 editor *= #ct_hx editor
scoreboard players operation #ct_t editor = #ct_hz editor
scoreboard players operation #ct_t editor *= #ct_hz editor
scoreboard players operation #ct_h2 editor += #ct_t editor
# 远（水平 > 1 格）：沿前进方向探 0..3 格，每格 1 宽 × 8 高（判定点上下各 4 格）× 1 深
execute if score #ct_h2 editor matches 1000001.. at @s rotated ~ 0 positioned ^ ^ ^0 positioned ~-0.5 ~-4 ~-0.5 if entity @a[tag=editor_active,dx=0,dy=7,dz=0] run scoreboard players set #ct_in editor 1
execute if score #ct_h2 editor matches 1000001.. at @s rotated ~ 0 positioned ^ ^ ^1 positioned ~-0.5 ~-4 ~-0.5 if entity @a[tag=editor_active,dx=0,dy=7,dz=0] run scoreboard players set #ct_in editor 1
execute if score #ct_h2 editor matches 1000001.. at @s rotated ~ 0 positioned ^ ^ ^2 positioned ~-0.5 ~-4 ~-0.5 if entity @a[tag=editor_active,dx=0,dy=7,dz=0] run scoreboard players set #ct_in editor 1
execute if score #ct_h2 editor matches 1000001.. at @s rotated ~ 0 positioned ^ ^ ^3 positioned ~-0.5 ~-4 ~-0.5 if entity @a[tag=editor_active,dx=0,dy=7,dz=0] run scoreboard players set #ct_in editor 1
# 近（水平 ≤ 1 格）：判定点为中心 3×3、竖直从判定点向上 4 格
execute if score #ct_h2 editor matches ..1000000 at @s positioned ~-1.5 ~ ~-1.5 if entity @a[tag=editor_active,dx=2,dy=3,dz=2] run scoreboard players set #ct_in editor 1

# ===== 3) 保护1：记录窗口 life ∈ [1,3x] 且在区域内 → 记录寿命（最后一刻记录为准）=====
execute if score #ct_life editor matches 1.. if score #ct_life editor <= #ct_x3 editor if score #ct_in editor matches 1 run scoreboard players operation @s editor_n_rec_life = #ct_life editor

# ===== 4) 待判段 p = c_last + 1（每刻最多判一段）=====
scoreboard players operation #ct_p editor = @s editor_n_c_last
scoreboard players add #ct_p editor 1
execute if score #ct_p editor > @s editor_n_seg_count run return 0
# #ct_short = 1 表示「末段过短、走延长窗口」
scoreboard players set #ct_short editor 0
execute if score #ct_p editor = @s editor_n_seg_count if score #ct_ext editor matches 1.. run scoreboard players set #ct_short editor 1
# 段 p 段末寿命 #ct_end = −min(p·d, dur)；段起点寿命 #ct_st = −(p−1)·d
scoreboard players operation #ct_end editor = #ct_p editor
scoreboard players operation #ct_end editor *= @s editor_n_density
execute if score #ct_end editor > @s editor_n_dur run scoreboard players operation #ct_end editor = @s editor_n_dur
scoreboard players operation #ct_end editor *= -1 const
scoreboard players operation #ct_st editor = #ct_p editor
scoreboard players remove #ct_st editor 1
scoreboard players operation #ct_st editor *= @s editor_n_density
scoreboard players operation #ct_st editor *= -1 const

# (a) 段内命中：已进入该段（life ≤ 段起点）且未到段末（life > 段末）且 在区域 → 大P
execute if score #ct_life editor <= #ct_st editor if score #ct_life editor > #ct_end editor if score #ct_in editor matches 1 run function rhythm_axe:editor/judge/concrete_perfect
# (b) 末段过短·延长窗口：life 已过 −dur、仍在 −dur−ext 内且 在区域 → 按 level(life + dur) 判级
execute if score #ct_short editor matches 1 if score #ct_life editor <= #ct_end editor if score #ct_life editor > #ct_neg editor if score #ct_in editor matches 1 run scoreboard players operation #ed_life editor = #ct_life editor
execute if score #ct_short editor matches 1 if score #ct_life editor <= #ct_end editor if score #ct_life editor > #ct_neg editor if score #ct_in editor matches 1 run scoreboard players operation #ed_life editor += @s editor_n_dur
execute if score #ct_short editor matches 1 if score #ct_life editor <= #ct_end editor if score #ct_life editor > #ct_neg editor if score #ct_in editor matches 1 run function rhythm_axe:editor/judge/concrete_level
# (c1) 首段保护1：段末不在区域但保护期有记录 → 按记录寿命判级
#     ★ 不带「末段不过短」门控（#ct_short）：单段 hold（seg_count==1）时首段即末段、dur<3x，
#       游玩侧 main_concrete:60-61 也**没有** ext 门控 ⇒ 同样按记录寿命判级（可为 bad）。
#       编辑器此前多写了 `#ct_short matches 0`，会少判一个 bad 场景（2026-09-21 与游玩对齐后删除）。
execute if score #ct_p editor matches 1 if score #ct_life editor <= #ct_end editor if score #ct_life editor >= #ct_neg editor if score #ct_in editor matches 0 if score @s editor_n_rec_life matches 0.. run scoreboard players operation #ed_life editor = @s editor_n_rec_life
execute if score #ct_p editor matches 1 if score #ct_life editor <= #ct_end editor if score #ct_life editor >= #ct_neg editor if score #ct_in editor matches 0 if score @s editor_n_rec_life matches 0.. run function rhythm_axe:editor/judge/concrete_level
# (c2) 段末仍在区域 → 大P
execute if score #ct_short editor matches 0 if score #ct_life editor <= #ct_end editor if score #ct_life editor >= #ct_neg editor if score #ct_in editor matches 1 run function rhythm_axe:editor/judge/concrete_perfect
# (c3) 段末不在区域 → miss。p≥2 直接 miss；p==1 且保护期无记录（rec<0）也 miss
#     ⚠ 不要写 `unless p matches 1 unless rec matches 0..` —— 链式 unless 是「两者都假」，不是「排除 (p==1 ∧ rec≥0)」
execute if score #ct_short editor matches 0 if score #ct_life editor <= #ct_end editor if score #ct_life editor >= #ct_neg editor if score #ct_in editor matches 0 if score #ct_p editor matches 2.. run function rhythm_axe:editor/judge/concrete_miss
execute if score #ct_short editor matches 0 if score #ct_life editor <= #ct_end editor if score #ct_life editor >= #ct_neg editor if score #ct_in editor matches 0 if score #ct_p editor matches 1 if score @s editor_n_rec_life matches ..-1 run function rhythm_axe:editor/judge/concrete_miss
# (d) 末段过短：延长窗口**恰好结束**那一刻仍未判 → miss（错过该刻则由 (e) 静默推进，不补播反馈）
#     ★ 加「本段未判」门控：单段 hold 时上面的 (c1) 可能在同一刻先按记录寿命判级（c_last 已 +1）
#       ⇒ 不能再 miss。游玩侧靠 note_c_seg_done 阻挡，编辑器用 c_last < seg_count 等价表达。
execute if score #ct_short editor matches 1 if score @s editor_n_c_last < @s editor_n_seg_count if score #ct_life editor = #ct_neg editor run function rhythm_axe:editor/judge/concrete_miss
# (e) 追赶兜底：寿命已低于本段下界（快进/拖进度条跳过了若干段）→ 每刻静默推进一段，不播反馈
execute if score #ct_life editor < #ct_neg editor if score @s editor_n_c_last < @s editor_n_seg_count run scoreboard players add @s editor_n_c_last 1
