#arg: mapid, index
# 彻底删除执行：删 trash[index] → 提示 → 刷新回收站
# ★ 2026-09-30 彻底删除时把该谱面的排行榜数据（scores / scores_index）一并清掉，不留孤儿数据
function rhythm_axe:play/highscore/clear with storage rhythm_axe:prop
$data remove storage rhythm_axe:maps trash[$(index)]
$tellraw @s [{"text":"已彻底删除谱面","color":"green"},{"text":"$(mapid)","color":"aqua"}]
function rhythm_axe:editor/menu/trash/trash_panel_open
