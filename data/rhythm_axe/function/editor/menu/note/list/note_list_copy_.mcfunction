#arg:cursor,index
# 复制该音符信息到剪贴板（行级：整音符副本；不刷新面板，与时间点/事件列表一致）
$data modify storage rhythm_axe:maps.editor note_clip set from storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)]
tellraw @s [{"text":"[编辑器] 已复制音符信息","color":"green"}]
