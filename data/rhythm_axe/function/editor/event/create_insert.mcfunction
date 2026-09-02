#arg:cursor,insert_index,new_time,commands
# 在 insert_index 处插入新事件点
$data modify storage rhythm_axe:maps.editor history[$(cursor)].events insert $(insert_index) value {\
    time:$(new_time),\
    commands:$(commands)\
}
