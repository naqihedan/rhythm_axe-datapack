#arg:mapid
# 打开谱面：存在 → 加载；不存在 → 新建默认结构
$execute if data storage rhythm_axe:maps.$(mapid) id run function rhythm_axe:editor/finish_open {mapid:"$(mapid)"}
$execute unless data storage rhythm_axe:maps.$(mapid) id run function rhythm_axe:editor/create_new {mapid:"$(mapid)"}
