#arg: mapid
# 目标谱面存储 rhythm_axe:maps.<mapid> 已存在（有 id 键）→ 弹**原生确认框**（★ 2026-10-01 统一）；否则直接还原（prop 含 mapid + index）
# storage 的 id 与路径是两个独立 token：此处 id=rhythm_axe:maps.<mapid>，路径=id
# 注：正在编辑同一张谱面时的拦截在 trash_restore_go 里统一做（两条入口都经过它）
$execute if data storage rhythm_axe:maps.$(mapid) id run data modify storage rhythm_axe:maps.editor pending_del set value {}
$execute if data storage rhythm_axe:maps.$(mapid) id run data modify storage rhythm_axe:maps.editor pending_del.kind set value "trash_restore"
$execute if data storage rhythm_axe:maps.$(mapid) id run data modify storage rhythm_axe:maps.editor pending_del.mapid set from storage rhythm_axe:prop mapid
$execute if data storage rhythm_axe:maps.$(mapid) id run data modify storage rhythm_axe:maps.editor pending_del.index set from storage rhythm_axe:prop index
$execute if data storage rhythm_axe:maps.$(mapid) id run data modify storage rhythm_axe:maps.editor pending_del.detail set value "目标 id 已经有谱面了，用回收站的版本覆盖它？\n⚠️ 被覆盖的那张会直接消失（不会进回收站）。"
$execute if data storage rhythm_axe:maps.$(mapid) id run function rhythm_axe:editor/menu/ops/confirm_delete
$execute unless data storage rhythm_axe:maps.$(mapid) id run function rhythm_axe:editor/menu/trash/trash_restore_go with storage rhythm_axe:prop
