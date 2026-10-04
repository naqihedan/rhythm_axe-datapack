# 执行分布（按钮 21101）：校验 → 重活提示 → 本刻/跨刻执行
#   校验口径必须和「真正会被改动的音符」一致 = notes 里的 selected 标记（df_dist_count 就是数它），
#   不能数 selection 数组：两者万一不同步（历史遗留/外部改写），数数组会「校验通过但改到别的音符」。
#   校验：① selected 标记 ≥2 颗 ② 起点 < 终点
function rhythm_axe:editor/menu/note/df/df_dist_count
execute store result score #op_count editor run data get storage rhythm_axe:maps.editor editing.df.k2
scoreboard players set #op_sel_n editor 0
execute store result score #op_sel_n editor run data get storage rhythm_axe:maps.editor selection
scoreboard players operation #op_diff editor = #op_count editor
scoreboard players operation #op_diff editor -= #op_sel_n editor
execute unless score #op_diff editor matches 0 run tellraw @s [{"text":"[编辑器] ","color":"gold"},{"text":"注意：选区列表与选中标记不一致（列表 ","color":"yellow"},{"score":{"name":"#op_sel_n","objective":"editor"},"color":"yellow"},{"text":" 个 / 实际标记 ","color":"yellow"},{"score":{"name":"#op_count","objective":"editor"},"color":"yellow"},{"text":" 颗），本次按实际标记执行","color":"yellow"}]
execute if score #op_count editor matches ..1 run tellraw @s [{"text":"[编辑器] ","color":"gold"},{"text":"分布需要至少选中 2 个音符","color":"red"}]
execute if score #op_count editor matches ..1 run data remove storage rhythm_axe:maps.editor editing.df.k
execute if score #op_count editor matches ..1 run data remove storage rhythm_axe:maps.editor editing.df.k2
execute if score #op_count editor matches ..1 run return fail
execute store result score #df_ca editor run data get storage rhythm_axe:maps.editor editing.df.t_a
execute store result score #df_cb editor run data get storage rhythm_axe:maps.editor editing.df.t_b
execute if score #df_ca editor >= #df_cb editor run tellraw @s [{"text":"[编辑器] ","color":"gold"},{"text":"起点必须小于终点","color":"red"}]
execute if score #df_ca editor >= #df_cb editor run return fail
# 重活提示：> 50 个音符 → 本刻只发提示，把活 schedule 到下一刻（否则提示会被一起渲染、玩家看不到）
#   op_label 由调用方（panel20）设好：时间分布 / 位置分布
function rhythm_axe:editor/util/op_announce with storage rhythm_axe:prop
execute if score #op_big editor matches 1 run schedule function rhythm_axe:editor/menu/note/df/df_dist_next 1t
execute if score #op_big editor matches 0 run function rhythm_axe:editor/menu/note/df/df_dist_go
