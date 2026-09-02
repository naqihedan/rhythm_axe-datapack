#arg: index
# 还原前置：存 pending.index + 复制 mapid 到 prop → 检查目标是否已存在（prop.index 由 consume 分发时写入）
$data modify storage rhythm_axe:maps.editor trash_pending.index set value $(index)
$data modify storage rhythm_axe:prop mapid set from storage rhythm_axe:maps trash[$(index)].mapid
function rhythm_axe:editor/menu/trash/trash_restore_check with storage rhythm_axe:prop
