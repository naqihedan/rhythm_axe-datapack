#arg:cursor,index
# 复制事件信息到剪贴板（只存指令列表，不含时间；不刷新面板）
$data modify storage rhythm_axe:maps.editor event_clip set from storage rhythm_axe:maps.editor history[$(cursor)].events[$(index)]
data remove storage rhythm_axe:maps.editor event_clip.time
tellraw @s [{"text":"[编辑器] 已复制事件信息（仅指令）","color":"green"}]
