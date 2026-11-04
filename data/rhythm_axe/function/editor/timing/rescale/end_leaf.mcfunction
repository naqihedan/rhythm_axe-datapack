#arg:cursor
# 缩放收尾·end_time 读取（宏叶子）
# 未定义 end_time → 不写 #rs_have_end（保持"未定义"语义，进度条显示为红色）
# ★ 值写到 #rs_end_v（map_fields 再拷进 #rs_t），避免本叶子和 fval 抢用 #rs_t
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].end_time run execute store result score #rs_end_v editor run data get storage rhythm_axe:maps.editor history[$(cursor)].end_time
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].end_time run scoreboard players set #rs_have_end editor 1