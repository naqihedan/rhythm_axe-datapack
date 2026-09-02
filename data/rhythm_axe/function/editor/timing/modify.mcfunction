# 修改时间点：前置 prop.index（时间点索引）+ prop.timing_fields（只 merge 传入的字段）
execute unless data storage rhythm_axe:prop index run tellraw @s [{"text":"[编辑器] 缺少索引（prop.index）","color":"red"}]
execute unless data storage rhythm_axe:prop index run return fail

function rhythm_axe:editor/file/begin
data modify storage rhythm_axe:prop cursor set from storage rhythm_axe:maps.editor history_cursor
function rhythm_axe:editor/timing/modify_ with storage rhythm_axe:prop
function rhythm_axe:editor/file/commit
function rhythm_axe:editor/refresh
tellraw @s [{"text":"[编辑器] 已修改时间点 ","color":"green"},{"nbt":"index","storage":"rhythm_axe:prop","color":"aqua"}]

data remove storage rhythm_axe:prop index
data remove storage rhythm_axe:prop timing_fields
data remove storage rhythm_axe:prop cursor
