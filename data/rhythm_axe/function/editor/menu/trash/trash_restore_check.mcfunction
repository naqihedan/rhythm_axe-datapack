#arg: mapid
# 目标 maps.$(mapid) 已存在 → 覆盖确认面板；否则直接还原（prop 含 mapid + index）
$execute if data storage rhythm_axe:maps.$(mapid) id run function rhythm_axe:editor/menu/trash/trash_restore_confirm with storage rhythm_axe:prop
$execute unless data storage rhythm_axe:maps.$(mapid) id run function rhythm_axe:editor/menu/trash/trash_restore_go with storage rhythm_axe:prop
