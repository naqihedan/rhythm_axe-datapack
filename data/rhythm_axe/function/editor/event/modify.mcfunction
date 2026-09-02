# 修改事件点：前置 prop.index（事件点索引）+ prop.event_fields（只 merge 传入的字段，如 commands）
execute unless data storage rhythm_axe:prop index run tellraw @s [{"text":"[编辑器] 缺少索引（prop.index）","color":"red"}]
execute unless data storage rhythm_axe:prop index run return fail

function rhythm_axe:editor/file/begin
data modify storage rhythm_axe:prop cursor set from storage rhythm_axe:maps.editor history_cursor

function rhythm_axe:editor/event/modify_ with storage rhythm_axe:prop
function rhythm_axe:editor/file/commit
function rhythm_axe:editor/refresh
tellraw @s [{"text":"[编辑器] 已修改事件点 ","color":"green"},{"nbt":"index","storage":"rhythm_axe:prop","color":"aqua"}]

data remove storage rhythm_axe:prop index
data remove storage rhythm_axe:prop event_fields
data remove storage rhythm_axe:prop cursor
