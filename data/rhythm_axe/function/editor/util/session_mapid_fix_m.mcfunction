#arg: cursor
# 会话自检修复（宏叶子）：editor.mapid 缺失 ⇒ 用工作副本 history[cursor].id 修回，并报告结果
$data modify storage rhythm_axe:maps.editor mapid set from storage rhythm_axe:maps.editor history[$(cursor)].id
execute if data storage rhythm_axe:maps.editor mapid run tellraw @s [{"text":"[编辑器] 会话数据异常：谱面 id 已从编辑内容自动恢复为 ","color":"yellow"},{"nbt":"mapid","storage":"rhythm_axe:maps.editor","color":"aqua"}]
execute unless data storage rhythm_axe:maps.editor mapid run tellraw @s [{"text":"[编辑器] 会话数据异常：缺少谱面 id 且无法自动恢复（编辑内容里也没有 id）","color":"red"}]
execute unless data storage rhythm_axe:maps.editor mapid run tellraw @s [{"text":"请退出编辑器后重新打开该谱面","color":"gray"}]
