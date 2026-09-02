#arg:cursor,index,list_name
# 插入点查找：元素不存在 → 末尾追加；存在 → 比较 time 决定在此插入或向后继续
$execute unless data storage rhythm_axe:maps.editor history[$(cursor)].$(list_name)[$(index)] run function rhythm_axe:editor/util/insert_mark_append
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].$(list_name)[$(index)] run function rhythm_axe:editor/util/insert_compare with storage rhythm_axe:prop
