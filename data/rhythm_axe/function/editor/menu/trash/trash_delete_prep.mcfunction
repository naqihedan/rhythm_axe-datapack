#arg: index
# 彻底删除前置：存 pending.index + pending.mapid + 复制 mapid 到 prop → 二次确认面板
$data modify storage rhythm_axe:maps.editor trash_pending.index set value $(index)
# ★ 必须同时记 mapid：确认面板的【彻底删除】(11272) 要读 trash_pending.mapid 传给 trash_delete_go
$data modify storage rhythm_axe:maps.editor trash_pending.mapid set from storage rhythm_axe:maps trash[$(index)].mapid
$data modify storage rhythm_axe:prop mapid set from storage rhythm_axe:maps trash[$(index)].mapid
function rhythm_axe:editor/menu/trash/trash_delete_confirm with storage rhythm_axe:prop
