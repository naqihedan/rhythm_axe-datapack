#arg:cursor,new_time,commands
# 追加事件点到 events 末尾
$data modify storage rhythm_axe:maps.editor history[$(cursor)].events append value {\
    time:$(new_time),\
    commands:$(commands)\
}
