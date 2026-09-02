#arg:cursor,insert_index,new_id,new_time,type,size,position_x,position_y,position_z,start_x,start_y,start_z,note_base_life,anim_easing,anim_power,hitsound,hit_particles,duration,color,density,following_point,custom_tag
# 在 insert_index 处插入新音符
$data modify storage rhythm_axe:maps.editor history[$(cursor)].notes insert $(insert_index) value {\
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
