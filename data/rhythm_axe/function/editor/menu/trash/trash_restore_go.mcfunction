#arg: mapid, index
# 还原执行：maps.$(mapid) = trash[index]（去掉多余 mapid 键）→ 删 trash[index] → 刷新回收站
$data modify storage rhythm_axe:maps.$(mapid) set from storage rhythm_axe:maps trash[$(index)]
$data remove storage rhythm_axe:maps.$(mapid).mapid
$data remove storage rhythm_axe:maps trash[$(index)]
$tellraw @s [{"text":"已还原谱面","color":"green"},{"text":"$(mapid)","color":"aqua"}]
function rhythm_axe:editor/menu/trash/trash_panel_open
