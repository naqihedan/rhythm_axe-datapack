#arg:cursor,i
# 单个时间点缩放（宏叶子）：time → f(t)
# ★ 时间点的时间**总是**跟着改（它是段边界，与开关无关）
# ⚠️ 不能写 return（会砍掉整条调用链，见 notes_leaf 顶部说明）
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].timing_points[$(i)].time run scoreboard players set #rs_done editor 0
$execute unless data storage rhythm_axe:maps.editor history[$(cursor)].timing_points[$(i)].time run scoreboard players set #rs_done editor 1
$execute if score #rs_done editor matches 0 run execute store result score #rs_t editor run data get storage rhythm_axe:maps.editor history[$(cursor)].timing_points[$(i)].time
execute if score #rs_done editor matches 0 run function rhythm_axe:editor/timing/rescale/fval
$execute if score #rs_done editor matches 0 unless score #rs_ft editor = #rs_t editor run execute store result storage rhythm_axe:maps.editor history[$(cursor)].timing_points[$(i)].time int 1 run scoreboard players get #rs_ft editor
# 首个时间点必须留在 0（f(0)=0 已保证；兜底防脏数据）
$execute if score #rs_done editor matches 0 if score #rs_i editor matches 0 if score #rs_ft editor matches 1.. run data modify storage rhythm_axe:maps.editor history[$(cursor)].timing_points[$(i)].time set value 0
