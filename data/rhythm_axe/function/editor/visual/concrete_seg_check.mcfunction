# 混凝土密度段判定检查（单实体调用，防多实体共享 #rel/#seg_time 串扰）
# @s = 混凝土展示实体（type=3, density>=1）
# 对齐游玩：段 k 结束 rel=min(k×density, dur)（k=1..seg_count）；首段=time+density，最后一段=time+dur（出窗判定）
# rel = playhead - time；rel == seg_time 且 seg ≤ seg_count 时判定
# ★ 必须"写→判"在同一函数内（@s 固定），否则多个混凝土会互相覆盖 #rel/#seg_time
scoreboard players operation #rel editor = #playhead editor
scoreboard players operation #rel editor -= @s editor_n_time
# ★ 段窗口起点：(seg-1)×density（对齐游玩 auto：段 1 在 rel=0 音符头到位时触发，而非段结束）
scoreboard players operation #seg_time editor = @s editor_n_seg
scoreboard players operation #seg_time editor -= 1 const
scoreboard players operation #seg_time editor *= @s editor_n_density
execute if score #seg_time editor > @s editor_n_dur run scoreboard players operation #seg_time editor = @s editor_n_dur
execute if score #playhead editor >= @s editor_n_time if score @s editor_n_seg <= @s editor_n_seg_count if score #rel editor = #seg_time editor if score #rel editor <= @s editor_n_dur run function rhythm_axe:editor/visual/concrete_seg_trigger
