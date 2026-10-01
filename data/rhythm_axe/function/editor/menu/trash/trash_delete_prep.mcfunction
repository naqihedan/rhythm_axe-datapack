#arg: index
# 彻底删除前置：写「待删对象」→ 弹**原生确认框**（★ 2026-10-01 用户要求，取代旧的聊天栏确认面板）
#   ⚠️ 必须同时记 mapid：确认后的 trash_delete_go 要拿它清排行榜数据（scores / scores_index）
data modify storage rhythm_axe:maps.editor pending_del set value {}
data modify storage rhythm_axe:maps.editor pending_del.kind set value "trash_delete"
$data modify storage rhythm_axe:maps.editor pending_del.index set value $(index)
$data modify storage rhythm_axe:maps.editor pending_del.mapid set from storage rhythm_axe:maps trash[$(index)].mapid
data modify storage rhythm_axe:maps.editor pending_del.detail set value "彻底删除回收站里的这张谱面？\n⚠️ 不可恢复，会连它的排行榜成绩一起清掉。"
function rhythm_axe:editor/menu/ops/confirm_delete
