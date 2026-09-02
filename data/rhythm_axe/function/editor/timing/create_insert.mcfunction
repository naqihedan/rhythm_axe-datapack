#arg:cursor,insert_index,new_time,bpm,bpb,tpb,judgement_scale
# 在 insert_index 处插入新时间点
$data modify storage rhythm_axe:maps.editor history[$(cursor)].timing_points insert $(insert_index) value {\
    time:$(new_time),\
    bpm:$(bpm),\
    bpb:$(bpb),\
    tpb:$(tpb),\
    judgement_scale:$(judgement_scale)\
}
