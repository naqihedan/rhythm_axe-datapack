#arg:cursor,index
# 复制时间点信息到剪贴板（不刷新面板）
$data modify storage rhythm_axe:maps.editor timing_clip set from storage rhythm_axe:maps.editor history[$(cursor)].timing_points[$(index)]
tellraw @s [{"text":"[编辑器] 已复制时间点信息","color":"green"}]
