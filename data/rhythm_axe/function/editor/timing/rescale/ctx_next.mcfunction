#arg:cursor,j
# 捕获缩放上下文·第二部分：下一个时间点 b（缺省 = 该段到谱尾，不写 b 键）
# 前置：prop.cursor、prop.j（= 被改时间点下标 + 1）
# ★ 二分不适用（要找「下一个」而非按 time 插入），下标直接 +1 即可 —— 数组按 time 升序，下一个就是 index+1
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].timing_points[$(j)] run data modify storage rhythm_axe:prop rescale.b set from storage rhythm_axe:maps.editor history[$(cursor)].timing_points[$(j)].time
$execute unless data storage rhythm_axe:maps.editor history[$(cursor)].timing_points[$(j)] run data remove storage rhythm_axe:prop rescale.b