#arg: slot, color, fp
# 把「百分之一格」的定点值算成「符号 / 整数部分 / 小数补零 / 两位小数」，写进 prop
#   ★ MC 的宏参数在**调用前**就会校验：$(i)/$(pad)/$(f)/$(sign) 必须先把值写进 prop，才能调 df_fmt_out
#   ★ 不用 {"nbt":"...字符串"} 渲染：字符串 NBT 会连引号一起显示（就是面板里 "0.00" 那个 bug）
$scoreboard players set #fm_fp editor $(fp)
scoreboard players set #fm_neg editor 0
execute if score #fm_fp editor matches ..-1 run scoreboard players set #fm_neg editor 1
scoreboard players set #fm_m1 editor -1
execute if score #fm_neg editor matches 1 run scoreboard players operation #fm_fp editor *= #fm_m1 editor
scoreboard players set #fm_c100 editor 100
scoreboard players operation #fm_ip editor = #fm_fp editor
scoreboard players operation #fm_ip editor /= #fm_c100 editor
scoreboard players operation #fm_fr editor = #fm_fp editor
scoreboard players operation #fm_fr editor %= #fm_c100 editor
data modify storage rhythm_axe:prop pad set value "0"
execute if score #fm_fr editor matches 10.. run data modify storage rhythm_axe:prop pad set value ""
data modify storage rhythm_axe:prop sign set value ""
execute if score #fm_neg editor matches 1 run data modify storage rhythm_axe:prop sign set value "-"
execute store result storage rhythm_axe:prop i int 1 run scoreboard players get #fm_ip editor
execute store result storage rhythm_axe:prop f int 1 run scoreboard players get #fm_fr editor
function rhythm_axe:editor/menu/note/df/df_fmt_out with storage rhythm_axe:prop
