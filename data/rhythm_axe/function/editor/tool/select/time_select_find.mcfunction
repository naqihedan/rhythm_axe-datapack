# 二分查找「第一个 time ≥ #ts_min 的下标」→ 结果落在 #ts_lo（不变式：答案在 [#ts_lo, #ts_hi] 内）
# 前置：#ts_lo=0、#ts_hi=#ts_len（全部 < min 时结果 = #ts_len）、#ts_two=2、prop.cursor
# ★ 目的：避免整表线性扫描（每个音符一次宏展开 ≈ 1 ms，几百个音符就是几百 ms，上千就撞 200k 上限）
execute if score #ts_lo editor >= #ts_hi editor run return 0
scoreboard players operation #ts_mid editor = #ts_lo editor
scoreboard players operation #ts_mid editor += #ts_hi editor
scoreboard players operation #ts_mid editor /= #ts_two editor
execute store result storage rhythm_axe:prop i int 1 run scoreboard players get #ts_mid editor
function rhythm_axe:editor/tool/select/time_select_probe with storage rhythm_axe:prop
execute if score #ts_time editor < #ts_min editor run scoreboard players operation #ts_lo editor = #ts_mid editor
execute if score #ts_time editor < #ts_min editor run scoreboard players add #ts_lo editor 1
execute unless score #ts_time editor < #ts_min editor run scoreboard players operation #ts_hi editor = #ts_mid editor
function rhythm_axe:editor/tool/select/time_select_find
