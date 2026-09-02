#arg:cursor,new_time,bpm,bpb,tpb,judgement_scale
# 追加时间点到 timing_points 末尾
$data modify storage rhythm_axe:maps.editor history[$(cursor)].timing_points append value {\
    time:$(new_time),\
    bpm:$(bpm),\
    bpb:$(bpb),\
    tpb:$(tpb),\
    judgement_scale:$(judgement_scale)\
}
