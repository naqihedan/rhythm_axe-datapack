#arg: index, mapid
# 检测回收站是否已有同 mapid（输出 #trash_has = 1 存在；调用前先置 0）
# ★ 用 trash_probe 临时键中转比较；复合匹配必须用根写法 storage <id> {path:{...}}（26.x 运行时 path+nbt 无效，实测）
$execute if data storage rhythm_axe:maps trash[$(index)] run data modify storage rhythm_axe:maps trash_probe set value {}
$execute if data storage rhythm_axe:maps trash[$(index)] run data modify storage rhythm_axe:maps trash_probe.mapid set from storage rhythm_axe:maps trash[$(index)].mapid
$execute if data storage rhythm_axe:maps {trash_probe:{mapid:"$(mapid)"}} run scoreboard players set #trash_has editor 1
$execute unless data storage rhythm_axe:maps trash[$(index)] run return 0
execute store result score #index editor run data get storage rhythm_axe:prop index
scoreboard players add #index editor 1
execute store result storage rhythm_axe:prop index int 1 run scoreboard players get #index editor
function rhythm_axe:editor/file/trash_has with storage rhythm_axe:prop
