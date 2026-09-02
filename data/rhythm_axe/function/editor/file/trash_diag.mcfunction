# 诊断回收站（/function rhythm_axe:editor/file/trash_diag）
tellraw @s ["=== 回收站诊断 ==="]
execute store result score #t editor run data get storage rhythm_axe:maps trash
execute if score #t editor matches 0 run tellraw @s ["trash 长度: 0"]
execute if score #t editor matches 1.. run tellraw @s ["trash 长度:",{"score":{"name":"#t","objective":"editor"}}]
# 1. trash[0] 是否存在 + mapid 值（标准 nbt 组件）
execute if data storage rhythm_axe:maps trash[0] run tellraw @s ["trash[0] 存在, mapid:",{"nbt":"trash[0].mapid","storage":"rhythm_axe:maps"}]
execute unless data storage rhythm_axe:maps trash[0] run tellraw @s ["trash[0] 不存在（旧复合或空）"]
# 2. trash_probe 中转
execute if data storage rhythm_axe:maps trash[0] run data modify storage rhythm_axe:maps trash_probe set value {}
execute if data storage rhythm_axe:maps trash[0] run data modify storage rhythm_axe:maps trash_probe.mapid set from storage rhythm_axe:maps trash[0].mapid
execute if data storage rhythm_axe:maps trash_probe run tellraw @s ["trash_probe 存在, mapid:",{"nbt":"trash_probe.mapid","storage":"rhythm_axe:maps"}]
execute unless data storage rhythm_axe:maps trash_probe run tellraw @s ["trash_probe 不存在"]
# 3. 复合匹配测试（多种写法）
execute if data storage rhythm_axe:maps trash[0] run execute if data storage rhythm_axe:maps.trash_probe {mapid:"test"} run tellraw @s ["写法A 点连接复合: 命中"]
execute if data storage rhythm_axe:maps trash[0] run execute unless data storage rhythm_axe:maps.trash_probe {mapid:"test"} run tellraw @s ["写法A 点连接复合: 未命中"]
execute if data storage rhythm_axe:maps trash[0] run execute if data storage rhythm_axe:maps {trash_probe:{mapid:"test"}} run tellraw @s ["写法B 根复合: 命中"]
execute if data storage rhythm_axe:maps trash[0] run execute unless data storage rhythm_axe:maps {trash_probe:{mapid:"test"}} run tellraw @s ["写法B 根复合: 未命中"]
