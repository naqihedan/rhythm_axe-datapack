# 执行填充（按钮 21102）：校验 → 重活提示 → 本刻/跨刻执行
#   校验：① 至少 1 个选中音符（当属性模板；选区内为空则没东西可继承）② 起点 < 终点
execute store result score #op_count editor run data get storage rhythm_axe:maps.editor selection
execute if score #op_count editor matches 0 run tellraw @s [{"text":"[编辑器] ","color":"gold"},{"text":"没有可复制的音符（先选中至少 1 个音符当属性模板）","color":"red"}]
execute if score #op_count editor matches 0 run return fail
execute store result score #df_ca editor run data get storage rhythm_axe:maps.editor editing.df.t_a
execute store result score #df_cb editor run data get storage rhythm_axe:maps.editor editing.df.t_b
execute if score #df_ca editor >= #df_cb editor run tellraw @s [{"text":"[编辑器] ","color":"gold"},{"text":"起点必须小于终点","color":"red"}]
execute if score #df_ca editor >= #df_cb editor run return fail
data modify storage rhythm_axe:prop op_label set value "插值填充"
function rhythm_axe:editor/util/op_announce with storage rhythm_axe:prop
execute if score #op_big editor matches 1 run schedule function rhythm_axe:editor/menu/note/df/df_fill_next 1t
execute if score #op_big editor matches 0 run function rhythm_axe:editor/menu/note/df/df_fill_go
