# 事件点检查（宏参数 ev_idx）：事件存在才继续，不存在则链终止
#arg: cursor, ev_idx
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].events[$(ev_idx)].time run function rhythm_axe:editor/visual/event_one_ with storage rhythm_axe:prop
