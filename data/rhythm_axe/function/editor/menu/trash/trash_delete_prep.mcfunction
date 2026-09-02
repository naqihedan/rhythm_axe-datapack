#arg: index
# 彻底删除前置：存 pending.index + 复制 mapid 到 prop → 二次确认面板
$data modify storage rhythm_axe:maps.editor trash_pending.index set value $(index)
$data modify storage rhythm_axe:prop mapid set from storage rhythm_axe:maps trash[$(index)].mapid
function rhythm_axe:editor/menu/trash/trash_delete_confirm with storage rhythm_axe:prop
