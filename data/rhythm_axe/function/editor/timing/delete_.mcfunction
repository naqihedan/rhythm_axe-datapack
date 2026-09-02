#arg:cursor,index
# 删除 timing_points[$(index)] 处的时间点
$data remove storage rhythm_axe:maps.editor history[$(cursor)].timing_points[$(index)]
