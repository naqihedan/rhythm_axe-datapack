#arg:cursor,list_name
# 末尾追加元素（confirm 链：insert_find 后无 insert_index 键 = append 模式）
$data modify storage rhythm_axe:maps.editor history[$(cursor)].$(list_name) append from storage rhythm_axe:prop tmp_elem
