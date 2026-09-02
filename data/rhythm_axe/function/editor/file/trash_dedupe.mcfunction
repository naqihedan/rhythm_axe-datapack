#arg: index, mapid
# 遍历回收站列表，移除同 mapid 旧元素（同名覆盖；删除前调用，回收站元素少，性能无忧）
# ★ 用 trash_probe 临时键中转比较；复合匹配必须用根写法 storage <id> {path:{...}}（26.x 运行时 path+nbt 无效，实测）
$execute if data storage rhythm_axe:maps trash[$(index)] run data modify storage rhythm_axe:maps trash_probe set value {}
$execute if data storage rhythm_axe:maps trash[$(index)] run data modify storage rhythm_axe:maps trash_probe.mapid set from storage rhythm_axe:maps trash[$(index)].mapid
$execute if data storage rhythm_axe:maps {trash_probe:{mapid:"$(mapid)"}} run data remove storage rhythm_axe:maps trash[$(index)]
$execute if data storage rhythm_axe:maps {trash_probe:{mapid:"$(mapid)"}} run return 0
$execute unless data storage rhythm_axe:maps trash[$(index)] run return 0
execute store result score #index editor run data get storage rhythm_axe:prop index
scoreboard players add #index editor 1
execute store result storage rhythm_axe:prop index int 1 run scoreboard players get #index editor
function rhythm_axe:editor/file/trash_dedupe with storage rhythm_axe:prop
