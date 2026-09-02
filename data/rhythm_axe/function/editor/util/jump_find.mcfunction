#arg:cursor,index,list_name
# 跳转目标查找：元素不存在 → 末尾处理（prev=跳最后记录 / next=无目标）；存在 → 比较
$execute unless data storage rhythm_axe:maps.editor history[$(cursor)].$(list_name)[$(index)] run function rhythm_axe:editor/util/jump_missing
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].$(list_name)[$(index)] run function rhythm_axe:editor/util/jump_compare with storage rhythm_axe:prop
