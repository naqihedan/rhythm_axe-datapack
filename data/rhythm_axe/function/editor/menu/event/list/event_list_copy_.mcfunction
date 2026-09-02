#arg:cursor,index
# 复制事件信息到剪贴板（不刷新面板）
$data modify storage rhythm_axe:maps.editor event_clip set from storage rhythm_axe:maps.editor history[$(cursor)].events[$(index)]
tellraw @s [{"text":"[编辑器] 已复制事件信息","color":"green"}]
