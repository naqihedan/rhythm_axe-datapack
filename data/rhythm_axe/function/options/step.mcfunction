#arg: key, delta, min, max
# 通用步进（设置面板用）：值 += delta，再钳到 [min, max]（越界钳到边界）
# key = 计分项名；delta = 每次步进量（**可负**）；min / max = 闭区间边界
#   ⚠️ 不要写 `scoreboard players add <key> <obj> -1`：`add` 的 count 只接受**正整数**
#      （要减得用 remove），写了这行会静默失败 → 表现就是「点了没反应」。所以这里先把
#      delta 落到临时计分项 #op_step，再用 operation += 做加法（计分板运算天然支持负值）。
#   ⚠️ 用 `matches ..$(min)` / `matches $(max)..` 做钳制：命中边界值本身时只是重设为同值，无副作用。
#   ⚠️ 只对 options 计分板生效（权重那几项走独立的 step_sc.mcfunction，objective 是 score_calculate）。
scoreboard players set #op_step menu 0
$scoreboard players set #op_step menu $(delta)
$scoreboard players operation $(key) options += #op_step menu
$execute if score $(key) options matches ..$(min) run scoreboard players set $(key) options $(min)
$execute if score $(key) options matches $(max).. run scoreboard players set $(key) options $(max)
