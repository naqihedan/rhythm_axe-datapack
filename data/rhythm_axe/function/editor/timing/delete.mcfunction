# 删除时间点：前置 prop.index；首个时间点（index 0）不可删除
execute unless data storage rhythm_axe:prop index run tellraw @s [{"text":"[编辑器] 缺少索引（prop.index）","color":"red"}]
execute unless data storage rhythm_axe:prop index run return fail
execute store result score #index editor run data get storage rhythm_axe:prop index
execute if score #index editor matches 0 run tellraw @s [{"text":"[编辑器] 不能删除第一个时间点","color":"red"}]
execute if score #index editor matches 0 run return fail

function rhythm_axe:editor/file/begin
data modify storage rhythm_axe:prop cursor set from storage rhythm_axe:maps.editor history_cursor
function rhythm_axe:editor/timing/delete_ with storage rhythm_axe:prop
function rhythm_axe:editor/file/commit
function rhythm_axe:editor/refresh
tellraw @s [{"text":"[编辑器] 已删除时间点 ","color":"green"},{"nbt":"index","storage":"rhythm_axe:prop","color":"aqua"}]

data remove storage rhythm_axe:prop index
data remove storage rhythm_axe:prop cursor
