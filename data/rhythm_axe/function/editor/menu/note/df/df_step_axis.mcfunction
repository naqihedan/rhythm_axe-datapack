#arg: list, idx, delta
# 空间端点单轴步进：editing.df.s_$(list)_fp[$(idx)] += $(delta)（单位 = 百分之一格，±50 = ±0.5）
#   list = "a"（从）/ "b"（到）；idx = 0/1/2（X/Y/Z）；delta = 50 / -50

$execute store result score #st editor run data get storage rhythm_axe:maps.editor editing.df.s_$(list)_fp[$(idx)]
scoreboard players set #st_d editor 0
$scoreboard players set #st_d editor $(delta)
scoreboard players operation #st editor += #st_d editor
$execute store result storage rhythm_axe:maps.editor editing.df.s_$(list)_fp[$(idx)] int 1 run scoreboard players get #st editor
