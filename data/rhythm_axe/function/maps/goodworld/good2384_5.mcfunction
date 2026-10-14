# 上飘第 4 段（+0.03125）并同时 scale-0
#   读当前 translation.y（×1e5 存进 g2384_y）-> 加增量 -> 按【float】写回
#   ★ 目标字段是 float 三元组，这里必须 float（写 double 会类型不符 -> 变形/抽搐）
#   ★ 依赖计分项 g2384_y（由 good2384_start 注册）
execute store result score @s g2384_y run data get entity @s transformation.translation[1] 100000
scoreboard players add @s g2384_y 3125
execute store result entity @s transformation.translation[1] float 0.00001 run scoreboard players get @s g2384_y
data merge entity @s {interpolation_duration: 4, start_interpolation: -1, transformation: {scale: [0.0f, 0.0f, 0.0f]}}
