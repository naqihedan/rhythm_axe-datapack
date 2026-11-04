#arg:cursor
# 缩放收尾·end_time 写回（宏叶子，仅一行）
$execute if score #rs_have_end editor matches 1 run execute store result storage rhythm_axe:maps.editor history[$(cursor)].end_time int 1 run scoreboard players get #rs_ft editor