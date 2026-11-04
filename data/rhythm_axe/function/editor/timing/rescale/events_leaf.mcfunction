#arg:cursor,i
# 单个事件点缩放（宏叶子）：time → f(t)
# 开关 editor_scale_event（【事件时间】）；缺 time 视为遍历结束（置 #rs_done=1）
# ⚠️ 不能写 return（会砍掉整条调用链，见 notes_leaf 顶部说明）
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].events[$(i)].time run scoreboard players set #rs_done editor 0
$execute unless data storage rhythm_axe:maps.editor history[$(cursor)].events[$(i)].time run scoreboard players set #rs_done editor 1
$execute if score #rs_done editor matches 0 run execute store result score #rs_t editor run data get storage rhythm_axe:maps.editor history[$(cursor)].events[$(i)].time
execute if score #rs_done editor matches 0 run function rhythm_axe:editor/timing/rescale/fval
$execute if score #rs_done editor matches 0 unless score #rs_ft editor = #rs_t editor if score editor_scale_event options matches 1 run execute store result storage rhythm_axe:maps.editor history[$(cursor)].events[$(i)].time int 1 run scoreboard players get #rs_ft editor
execute if score #rs_done editor matches 0 unless score #rs_ft editor = #rs_t editor if score editor_scale_event options matches 1 run scoreboard players add #rs_ev editor 1
