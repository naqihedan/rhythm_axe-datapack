# 配对交互实体位置写入：@s = 与当前 place 的展示实体同 note_id 的 interaction
# ★ 2026-09-14 性能重构：原 place 里 7 条 `execute as @e[type=interaction,tag=editor_note] if score @s note_id = #iid ...`
#   （每条遍历全部 interaction 实体）合并为「1 次选择器 + 本函数全 @s」。
#   place 每 tick 每音符都调用 ⇒ 原为 O(n²)/tick，现降 7 倍。
# ★ 本文件【不得】出现宏行（$ 开头）。
# 前置（place 已算好）：editor 计分板 #ix #iy #iz（世界坐标 ×1000）；#pl = 当前是否播放中（0/1）
# ★ 2026-10-03 性能（实测归因）：实体 NBT 写很贵（每次写都会把实体标脏→向客户端同步）。
#   实测：52 音符同屏时全部屏蔽掉 → 密集段每刻中位数 64ms → 24ms。
#   ① Pos 分 3 次写（Pos[0..2]）——尝试合并成 1 次整表写实测会把 Pos 写成 0（26.2 不可用），故保持分写。
#   ② Axiom 用的 editor_should_* 拆到 place_inter_should，仅在编辑期（非播放）执行。
execute store result entity @s Pos[0] double 0.001 run scoreboard players get #ix editor
execute store result entity @s Pos[1] double 0.001 run scoreboard players get #iy editor
execute store result entity @s Pos[2] double 0.001 run scoreboard players get #iz editor
execute unless score #pl editor matches 1 run function rhythm_axe:editor/visual/place_inter_should
# 快照"应该在的位置"到交互实体（Axiom 偏移检测用；每次 place 覆写）
#   ★ 2026-10-03：拆入 place_inter_should，并**仅在编辑期（非播放）执行**（播放中 4 次实体写纯浪费）
execute unless score #pl editor matches 1 run function rhythm_axe:editor/visual/place_inter_should
