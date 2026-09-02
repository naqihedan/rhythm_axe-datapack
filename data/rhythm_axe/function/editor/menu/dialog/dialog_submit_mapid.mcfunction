#arg:value
# ★ 2026-08-25 增强重名检查：id/notes/title 任一存在即视为已有谱面（防覆盖；兼容残留/损坏谱面）；提示带重名 mapid
$execute if data storage rhythm_axe:maps.$(value) id run tellraw @s [{"text":"[编辑器] 已存在同名谱面（","color":"red"},{"text":"$(value)","color":"aqua"},{"text":"），改名失败","color":"red"}]
$execute if data storage rhythm_axe:maps.$(value) id run return fail
$execute if data storage rhythm_axe:maps.$(value) notes run tellraw @s [{"text":"[编辑器] 已存在同名谱面（","color":"red"},{"text":"$(value)","color":"aqua"},{"text":"），改名失败","color":"red"}]
$execute if data storage rhythm_axe:maps.$(value) notes run return fail
$execute if data storage rhythm_axe:maps.$(value) title run tellraw @s [{"text":"[编辑器] 已存在同名谱面（","color":"red"},{"text":"$(value)","color":"aqua"},{"text":"），改名失败","color":"red"}]
$execute if data storage rhythm_axe:maps.$(value) title run return fail
$data modify storage rhythm_axe:prop new_mapid set value "$(value)"
data modify storage rhythm_axe:prop old_mapid set from storage rhythm_axe:maps.editor mapid
# cursor 传给 map_rename（未保存源谱面从工作副本 history[cursor] 创建正式存储）
execute store result storage rhythm_axe:prop cursor int 1 run data get storage rhythm_axe:maps.editor history_cursor
function rhythm_axe:editor/menu/map/ops/map_rename with storage rhythm_axe:prop
