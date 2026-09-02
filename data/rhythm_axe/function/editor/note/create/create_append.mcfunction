#arg:cursor,new_id,new_time,type,size,position_x,position_y,position_z,start_x,start_y,start_z,note_base_life,anim_easing,anim_power,hitsound,hit_particles,duration,color,density,following_point,custom_tag
# 追加到 notes 末尾
$data modify storage rhythm_axe:maps.editor history[$(cursor)].notes append value {\
    id:$(new_id),\
    time:$(new_time),\
    type:$(type),\
    size:$(size),\
    position:[$(position_x),$(position_y),$(position_z)],\
    start_pos:[$(start_x),$(start_y),$(start_z)],\
    note_base_life:$(note_base_life),\
    anim_easing:$(anim_easing),\
    anim_power:$(anim_power),\
    hitsound:$(hitsound),\
    hit_particles:$(hit_particles),\
    duration:$(duration),\
    color:$(color),\
    density:$(density),\
    following_point:$(following_point),\
    custom_tag:"$(custom_tag)"\
}
