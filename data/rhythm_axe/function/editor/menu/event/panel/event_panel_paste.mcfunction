# 面板【粘贴】：剪贴板指令列表写入暂存副本（保留暂存原 time）并刷新面板
execute unless data storage rhythm_axe:maps.editor event_clip run tellraw @s [{"text":"[编辑器] 剪贴板为空，先复制一个事件","color":"red"}]
execute unless data storage rhythm_axe:maps.editor event_clip run return fail
data modify storage rhythm_axe:maps.editor editing.temp.commands set from storage rhythm_axe:maps.editor event_clip.commands
tellraw @s [{"text":"[编辑器] 已粘贴事件指令（保留原时间）","color":"green"}]
function rhythm_axe:editor/menu/event/panel/event_panel
