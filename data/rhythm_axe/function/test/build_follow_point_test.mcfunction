# 构建测试谱面（手动测试用）
# 运行后：function rhythm_axe:play/start_of_game/start_of_game {mapid:"follow_point"}
# 1.21.5+ 空路径不可用：逐键清空（if data 保护避免报错）+ merge 覆盖根
# （merge 直接合并到根，无需路径）
execute if data storage rhythm_axe:maps.follow_point timing_points run data remove storage rhythm_axe:maps.follow_point timing_points
execute if data storage rhythm_axe:maps.follow_point notes run data remove storage rhythm_axe:maps.follow_point notes
execute if data storage rhythm_axe:maps.follow_point events run data remove storage rhythm_axe:maps.follow_point events
data merge storage rhythm_axe:maps.follow_point {id:"follow_point",title:'{"text":"测试谱面"}',artist:"测试",music:"rhythm_axe:rhythm_axe.audio",health:1000,player_count:1,end_time:256,teleport:0b}

# 时间点
data modify storage rhythm_axe:maps.follow_point timing_points append value {time:0,bpm:150,bpb:4,tpb:4,judgement_scale:1}

# 线性
data modify storage rhythm_axe:maps.follow_point notes append value {id:0,type:0,time:0,note_base_life:16,size:0.8,anim_easing:1,anim_power:1,position:[-0.5,0.5,0.5],start_pos:[0.0,0.0,16.0]}
data modify storage rhythm_axe:maps.follow_point notes append value {id:1,type:0,time:8,note_base_life:16,size:0.8,anim_easing:1,anim_power:1,position:[-2.5,0.5,0.5],start_pos:[0.0,0.0,16.0],following_point:true}
data modify storage rhythm_axe:maps.follow_point notes append value {id:2,type:0,time:16,note_base_life:16,size:0.8,anim_easing:1,anim_power:1,position:[-1.5,2.5,0.5],start_pos:[0.0,0.0,16.0],following_point:true}
data modify storage rhythm_axe:maps.follow_point notes append value {id:3,type:0,time:24,note_base_life:16,size:0.8,anim_easing:1,anim_power:1,position:[-0.5,0.5,0.5],start_pos:[0.0,0.0,16.0],following_point:true}

data modify storage rhythm_axe:maps.follow_point notes append value {id:4,type:0,time:32,note_base_life:16,size:0.8,anim_easing:1,anim_power:1,position:[-0.5,0.5,0.5],start_pos:[0.0,0.0,16.0]}
data modify storage rhythm_axe:maps.follow_point notes append value {id:5,type:0,time:40,note_base_life:16,size:0.8,anim_easing:1,anim_power:1,position:[-2.5,0.5,0.5],start_pos:[0.0,0.0,16.0],following_point:true}
data modify storage rhythm_axe:maps.follow_point notes append value {id:6,type:0,time:48,note_base_life:16,size:0.8,anim_easing:1,anim_power:1,position:[-1.5,2.5,0.5],start_pos:[0.0,0.0,16.0],following_point:true}
data modify storage rhythm_axe:maps.follow_point notes append value {id:7,type:0,time:56,note_base_life:16,size:0.8,anim_easing:1,anim_power:1,position:[-0.5,0.5,0.5],start_pos:[0.0,0.0,16.0],following_point:true}

# 缓动
data modify storage rhythm_axe:maps.follow_point notes append value {id:8,type:0,time:64,note_base_life:16,size:0.8,anim_easing:3,anim_power:3,position:[-0.5,0.5,0.5],start_pos:[0.0,0.0,16.0]}
data modify storage rhythm_axe:maps.follow_point notes append value {id:9,type:0,time:72,note_base_life:16,size:0.8,anim_easing:3,anim_power:3,position:[-2.5,0.5,0.5],start_pos:[0.0,0.0,16.0],following_point:true}
data modify storage rhythm_axe:maps.follow_point notes append value {id:10,type:0,time:80,note_base_life:16,size:0.8,anim_easing:3,anim_power:3,position:[-1.5,2.5,0.5],start_pos:[0.0,0.0,16.0],following_point:true}
data modify storage rhythm_axe:maps.follow_point notes append value {id:11,type:0,time:88,note_base_life:16,size:0.8,anim_easing:3,anim_power:3,position:[-0.5,0.5,0.5],start_pos:[0.0,0.0,16.0],following_point:true}

data modify storage rhythm_axe:maps.follow_point notes append value {id:12,type:0,time:96,note_base_life:16,size:0.8,anim_easing:3,anim_power:3,position:[-0.5,0.5,0.5],start_pos:[0.0,0.0,16.0]}
data modify storage rhythm_axe:maps.follow_point notes append value {id:13,type:0,time:104,note_base_life:16,size:0.8,anim_easing:3,anim_power:3,position:[-2.5,0.5,0.5],start_pos:[0.0,0.0,16.0],following_point:true}
data modify storage rhythm_axe:maps.follow_point notes append value {id:14,type:0,time:112,note_base_life:16,size:0.8,anim_easing:3,anim_power:3,position:[-1.5,2.5,0.5],start_pos:[0.0,0.0,16.0],following_point:true}
data modify storage rhythm_axe:maps.follow_point notes append value {id:15,type:0,time:120,note_base_life:16,size:0.8,anim_easing:3,anim_power:3,position:[-0.5,0.5,0.5],start_pos:[0.0,0.0,16.0],following_point:true}

# 创意应用

data modify storage rhythm_axe:maps.follow_point notes append value {id:16,type:0,time:160,note_base_life:32,size:0.8,anim_easing:2,anim_power:4,position:[-0.5,0.5,0.5],start_pos:[0.0,0.0,16.0]}
data modify storage rhythm_axe:maps.follow_point notes append value {id:17,type:0,time:168,note_base_life:32,size:0.8,anim_easing:2,anim_power:4,position:[-2.5,0.5,0.5],start_pos:[0.0,0.0,16.0],following_point:true}
data modify storage rhythm_axe:maps.follow_point notes append value {id:18,type:0,time:176,note_base_life:32,size:0.8,anim_easing:2,anim_power:4,position:[-1.5,2.5,0.5],start_pos:[0.0,0.0,16.0],following_point:true}
data modify storage rhythm_axe:maps.follow_point notes append value {id:19,type:0,time:184,note_base_life:32,size:0.8,anim_easing:2,anim_power:4,position:[-0.5,0.5,0.5],start_pos:[0.0,0.0,16.0],following_point:true}

data modify storage rhythm_axe:maps.follow_point notes append value {id:20,type:0,time:224,note_base_life:32,size:0.8,anim_easing:2,anim_power:4,position:[-0.5,0.5,0.5],start_pos:[0.0,0.0,16.0]}
data modify storage rhythm_axe:maps.follow_point notes append value {id:21,type:0,time:232,note_base_life:32,size:0.8,anim_easing:2,anim_power:4,position:[-2.5,0.5,0.5],start_pos:[0.0,0.0,16.0],following_point:true}
data modify storage rhythm_axe:maps.follow_point notes append value {id:22,type:0,time:240,note_base_life:32,size:0.8,anim_easing:2,anim_power:4,position:[-1.5,2.5,0.5],start_pos:[0.0,0.0,16.0],following_point:true}
data modify storage rhythm_axe:maps.follow_point notes append value {id:23,type:0,time:248,note_base_life:32,size:0.8,anim_easing:2,anim_power:4,position:[-0.5,0.5,0.5],start_pos:[0.0,0.0,16.0],following_point:true}



tellraw @a [{"text":"引导线测试谱面已构建！开始游玩：","color":"yellow"},{"text":"/function rhythm_axe:play/start_of_game/start_of_game {mapid:\"follow_point\"}","color":"green"}]
