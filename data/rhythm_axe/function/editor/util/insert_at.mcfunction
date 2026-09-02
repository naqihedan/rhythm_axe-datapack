#arg:cursor,list_name,insert_index
# 在指定索引插入元素（confirm 链：insert_find 后 insert_index 已算出；调用时 compound 必须含这三个键）
$data modify storage rhythm_axe:maps.editor history[$(cursor)].$(list_name) insert $(insert_index) from storage rhythm_axe:prop tmp_elem
