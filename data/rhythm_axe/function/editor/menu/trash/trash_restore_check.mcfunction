#arg: mapid
# 目标谱面存储 rhythm_axe:maps.<mapid> 已存在（有 id 键）→ 覆盖确认面板；否则直接还原（prop 含 mapid + index）
# storage 的 id 与路径是两个独立 token：此处 id=rhythm_axe:maps.<mapid>，路径=id
# 注：正在编辑同一张谱面时的拦截在 trash_restore_go 里统一做（两条入口都经过它）
$execute if data storage rhythm_axe:maps.$(mapid) id run function rhythm_axe:editor/menu/trash/trash_restore_confirm with storage rhythm_axe:prop
$execute unless data storage rhythm_axe:maps.$(mapid) id run function rhythm_axe:editor/menu/trash/trash_restore_go with storage rhythm_axe:prop
