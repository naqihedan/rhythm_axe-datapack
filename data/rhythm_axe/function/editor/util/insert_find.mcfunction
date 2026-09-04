#arg:cursor,index,list_name
# 插入点查找：元素不存在 → 末尾追加；存在 → 比较 time 决定在此插入或向后继续
$execute unless data storage rhythm_axe:maps.editor history[$(cursor)].$(list_name)[$(index)] run function rhythm_axe:editor/util/insert_mark_append
# ★ 终止分支必须 return 0（否则 insert_mark_append 后继续执行剩余行 → compare/advance → 无限递归 → 200000 超限）
$execute unless data storage rhythm_axe:maps.editor history[$(cursor)].$(list_name)[$(index)] run return 0
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].$(list_name)[$(index)] run function rhythm_axe:editor/util/insert_compare with storage rhythm_axe:prop
