# 配对交互实体位置写入：@s = 与当前 place 的展示实体同 note_id 的 interaction
# ★ 2026-09-14 性能重构：原 place 里 7 条 `execute as @e[type=interaction,tag=editor_note] if score @s note_id = #iid ...`
#   （每条遍历全部 interaction 实体）合并为「1 次选择器 + 本函数全 @s」。
#   place 每 tick 每音符都调用 ⇒ 原为 O(n²)/tick，现降 7 倍。
# ★ 本文件【不得】出现宏行（$ 开头）。
# 前置（place 已算好）：editor 计分板 #ix #iy #iz（世界坐标 ×1000）
execute store result entity @s Pos[0] double 0.001 run scoreboard players get #ix editor
execute store result entity @s Pos[1] double 0.001 run scoreboard players get #iy editor
execute store result entity @s Pos[2] double 0.001 run scoreboard players get #iz editor
# 快照"应该在的位置"到交互实体（Axiom 偏移检测用；每次 place 覆写）
#   交互实体实际 Pos 被 Axiom 移动后，其与 editor_should_x/y/z 的差 = 手动偏移，shift+左击时读到判定位置
data merge entity @s {data:{editor_should_x:0.0d,editor_should_y:0.0d,editor_should_z:0.0d}}
execute store result entity @s data.editor_should_x double 0.001 run scoreboard players get #ix editor
execute store result entity @s data.editor_should_y double 0.001 run scoreboard players get #iy editor
execute store result entity @s data.editor_should_z double 0.001 run scoreboard players get #iz editor
