#arg: mapid, index
# 彻底删除执行：删 trash[index] → 提示 → 刷新回收站
$data remove storage rhythm_axe:maps trash[$(index)]
$tellraw @s [{"text":"已彻底删除谱面","color":"green"},{"text":"$(mapid)","color":"aqua"}]
function rhythm_axe:editor/menu/trash/trash_panel_open
