# 面板【复制】：正在编辑的暂存副本存剪贴板（不刷新）
data modify storage rhythm_axe:maps.editor event_clip set from storage rhythm_axe:maps.editor editing.temp
tellraw @s [{"text":"[编辑器] 已复制事件信息","color":"green"}]
