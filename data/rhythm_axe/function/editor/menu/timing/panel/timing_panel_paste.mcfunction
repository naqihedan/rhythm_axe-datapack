# 面板【粘贴】：剪贴板信息写入暂存副本并刷新面板
execute unless data storage rhythm_axe:maps.editor timing_clip run tellraw @s [{"text":"[编辑器] 剪贴板为空，先复制一个时间点","color":"red"}]
execute unless data storage rhythm_axe:maps.editor timing_clip run return fail
data modify storage rhythm_axe:maps.editor editing.temp set from storage rhythm_axe:maps.editor timing_clip
tellraw @s [{"text":"[编辑器] 已粘贴时间点信息","color":"green"}]
function rhythm_axe:editor/menu/timing/panel/timing_panel
