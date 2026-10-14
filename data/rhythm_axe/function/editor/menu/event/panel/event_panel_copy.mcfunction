# 面板【复制】：正在编辑的暂存副本的指令列表存剪贴板（不含时间，不刷新）
data modify storage rhythm_axe:maps.editor event_clip set from storage rhythm_axe:maps.editor editing.temp
data remove storage rhythm_axe:maps.editor event_clip.time
tellraw @s [{"text":"[编辑器] 已复制事件信息（仅指令）","color":"green"}]
