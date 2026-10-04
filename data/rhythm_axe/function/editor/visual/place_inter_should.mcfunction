# Axiom 手动偏移检测用的 "应该在的位置" 快照（editor_should_*）
# ★ 2026-10-03 拆出来是为了能按时机门控：只在**编辑期**（非播放）需要，
#   播放中每音符每刻写这 4 次实体 NBT 纯属浪费（实测占每音符每刻 7 次实体写的 4 次）。
# 原理：交互实体实际 Pos 被 Axiom 移动后，其与 editor_should_x/y/z 的差 = 手动偏移，
#       shift+左击时据此读到判定位置（详见 place / 编辑器.md）
# 前置：place 已算好 #ix #iy #iz；@s = 配对的交互实体
data merge entity @s {data:{editor_should_x:0.0d,editor_should_y:0.0d,editor_should_z:0.0d}}
execute store result entity @s data.editor_should_x double 0.001 run scoreboard players get #ix editor
execute store result entity @s data.editor_should_y double 0.001 run scoreboard players get #iy editor
execute store result entity @s data.editor_should_z double 0.001 run scoreboard players get #iz editor
