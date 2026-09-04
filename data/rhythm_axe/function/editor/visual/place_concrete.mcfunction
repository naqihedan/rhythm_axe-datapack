# 混凝土（3）定位：@s = 展示实体
# ★ 2026-08-26 按文档/游玩三段模型重构：
#   短 hold（dur<=lt）：段①头动尾停 → 段②整体平移 → 段③头停尾动
#   长 hold（dur>lt）：段①头动 → 段②静止 → 段③尾动
# 局部 z：+z=运动方向、判定=0、出生=-d、s=size。
# 头端终点 = s/2（判定+size/2）；出生中心（len=0）= s/2-d（尾端起点）
# 段分界（playhead 时刻）：seg1_end = birth+min(dur,lt)；seg2_end = time+max(0,dur-lt)；end = time+dur
# #half_sz（size/2×100）、#seg1_end、#seg2_end 供 s1/s2/s3 使用
# 算 size/2×100（editor_n_size = size×1000 → /20）
scoreboard players operation #half_sz editor = @s editor_n_size
scoreboard players operation #half_sz editor /= 20 const
# ★ 2026-09-04 修复流速缩放不一致：把实体 editor_n_lt 覆写为「有效寿命」#life（=time-birth，已含流速缩放），
#   此后所有短/长判定（dur vs lt）、段①③时长、段②结束、全长都按有效寿命走 → 慢流速时三段速度一致。
#   此前 editor_n_lt 是基础寿命（未缩放），短 hold 长度与长 hold 段②③用基础寿命，慢流速时头尾快、中段慢。
scoreboard players operation #life editor = @s editor_n_time
scoreboard players operation #life editor -= @s editor_n_birth
execute if score #life editor matches ..0 run scoreboard players set #life editor 1
execute if score #life editor matches 1.. run scoreboard players operation @s editor_n_lt = #life editor
# 修正长条全长目标（×100）#L100（预置给 s1/s2/s3 用，替代原先用基础寿命烘的 editor_n_len）：
#   短 hold（dur<=有效寿命）= dist×dur/有效寿命；长 hold（dur>有效寿命）= dist+size（size×100 = #half_sz×2）
scoreboard players operation #L100 editor = @s editor_n_dist
execute if score @s editor_n_dur <= @s editor_n_lt run scoreboard players operation #L100 editor *= @s editor_n_dur
execute if score @s editor_n_dur <= @s editor_n_lt run scoreboard players operation #L100 editor /= @s editor_n_lt
execute if score @s editor_n_dur > @s editor_n_lt run scoreboard players operation #L100 editor += #half_sz editor
execute if score @s editor_n_dur > @s editor_n_lt run scoreboard players operation #L100 editor += #half_sz editor
# 算段分界
# ★ 2026-09-01 流速缩放（★ 09-01 二次修正：短 hold 段①=dur 固定，不缩放——同游玩 duration 固定）：
#   段①（拉伸）时长——短 hold（dur<=有效寿命）= dur 固定；长 hold（dur>有效寿命）= 有效寿命（到判定时刻）。
#   段②（平移/静止）结束 = seg2_end；段③（收缩）时长固定（短 hold=dur / 长 hold=有效寿命），与游玩一致。
scoreboard players operation #scale editor = @s editor_n_time
scoreboard players operation #scale editor -= @s editor_n_birth
execute if score @s editor_n_lt matches 1.. run scoreboard players operation #scale editor /= @s editor_n_lt
scoreboard players operation #seg1_dur editor = @s editor_n_dur
execute if score @s editor_n_dur > @s editor_n_lt run scoreboard players operation #seg1_dur editor = @s editor_n_lt
execute if score @s editor_n_dur > @s editor_n_lt run scoreboard players operation #seg1_dur editor *= #scale editor
scoreboard players operation #seg1_end editor = @s editor_n_birth
scoreboard players operation #seg1_end editor += #seg1_dur editor
scoreboard players operation #seg2_end editor = @s editor_n_time
execute if score @s editor_n_dur > @s editor_n_lt run scoreboard players operation #seg2_end editor += @s editor_n_dur
execute if score @s editor_n_dur > @s editor_n_lt run scoreboard players operation #seg2_end editor -= @s editor_n_lt
# 长条分段（互斥；#seg 供调试输出标注当前段）
execute if score #playhead editor <= #seg1_end editor run scoreboard players set #seg editor 1
execute if score #playhead editor > #seg1_end editor if score #playhead editor <= #seg2_end editor run scoreboard players set #seg editor 2
execute if score #playhead editor > #seg2_end editor run scoreboard players set #seg editor 3
execute if score #playhead editor <= #seg1_end editor run function rhythm_axe:editor/visual/place_concrete_s1
execute if score #playhead editor > #seg1_end editor if score #playhead editor <= #seg2_end editor run function rhythm_axe:editor/visual/place_concrete_s2
execute if score #playhead editor > #seg2_end editor run function rhythm_axe:editor/visual/place_concrete_s3
