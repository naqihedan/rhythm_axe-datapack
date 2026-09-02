#arg:cursor,index
# 删除 events[$(index)] 处的事件点
$data remove storage rhythm_axe:maps.editor history[$(cursor)].events[$(index)]
