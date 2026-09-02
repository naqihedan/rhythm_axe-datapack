# 构建缓动测试谱面（验证非线性兜底路径，2026-08-08）
# 覆盖：普通音符 display_animation（一次）+ 染色玻璃 display_animation（两段镜像）
# 运行后：function rhythm_axe:play/start_of_game/start_of_game {mapid:"easingtest"}
# 1.21.5+ 空路径不可用：逐键清空 + merge 覆盖根
execute if data storage rhythm_axe:maps.easingtest timing_points run data remove storage rhythm_axe:maps.easingtest timing_points
execute if data storage rhythm_axe:maps.easingtest notes run data remove storage rhythm_axe:maps.easingtest notes
execute if data storage rhythm_axe:maps.easingtest events run data remove storage rhythm_axe:maps.easingtest events
data merge storage rhythm_axe:maps.easingtest {id:"easingtest",title:'{"text":"缓动测试"}',artist:"测试",music:"rhythm_axe:rhythm_axe.audio",health:1000,player_count:1,end_time:200,teleport:0b}
data modify storage rhythm_axe:maps.easingtest timing_points append value {time:0,bpm:150,bpb:4,tpb:2,judgement_scale:1}

# 普通音符（type 0）：缓入缓出 power=3 → display_animation 一次（tick.mcfunction 逐帧驱动）
data modify storage rhythm_axe:maps.easingtest notes append value {id:0,type:0,time:0,note_base_life:16,size:1.0,anim_easing:3,anim_power:3,position:[0.5,0.5,0.5],start_pos:[0.0,0.0,16.0]}
data modify storage rhythm_axe:maps.easingtest notes append value {id:1,type:0,time:16,note_base_life:16,size:1.0,anim_easing:3,anim_power:3,position:[0.5,0.5,0.5],start_pos:[0.0,0.0,16.0]}
# 普通音符（type 0）：缓出 power=5 → display_animation 一次
data modify storage rhythm_axe:maps.easingtest notes append value {id:2,type:0,time:32,note_base_life:16,size:1.0,anim_easing:2,anim_power:5,position:[0.5,0.5,0.5],start_pos:[0.0,0.0,16.0]}
data modify storage rhythm_axe:maps.easingtest notes append value {id:3,type:0,time:48,note_base_life:16,size:1.0,anim_easing:2,anim_power:5,position:[0.5,0.5,0.5],start_pos:[0.0,0.0,16.0]}
# 染色玻璃（type 4）：缓入缓出 power=3、duration=8 → display_animation 两段镜像
data modify storage rhythm_axe:maps.easingtest notes append value {id:4,type:4,time:64,note_base_life:16,size:1.0,duration:8,anim_easing:3,anim_power:3,position:[0.5,0.5,0.5],start_pos:[0.0,0.0,16.0]}
data modify storage rhythm_axe:maps.easingtest notes append value {id:5,type:4,time:80,note_base_life:16,size:1.0,duration:8,anim_easing:3,anim_power:3,position:[0.5,0.5,0.5],start_pos:[0.0,0.0,16.0]}
# 染色玻璃（type 4）：缓出 power=2、duration=4 → display_animation 两段镜像
data modify storage rhythm_axe:maps.easingtest notes append value {id:6,type:4,time:96,note_base_life:16,size:1.0,duration:4,anim_easing:2,anim_power:2,position:[0.5,0.5,0.5],start_pos:[0.0,0.0,16.0]}
data modify storage rhythm_axe:maps.easingtest notes append value {id:7,type:4,time:112,note_base_life:16,size:1.0,duration:4,anim_easing:2,anim_power:2,position:[0.5,0.5,0.5],start_pos:[0.0,0.0,16.0]}
# 混凝土（type 3）：缓入缓出 power=3、duration=8 → 头/尾各一次缓动
#   （阶段2 曾线性化，C 阶段已加回 easing）
data modify storage rhythm_axe:maps.easingtest notes append value {id:8,type:3,time:128,note_base_life:16,size:1.0,duration:8,density:8,anim_easing:3,anim_power:3,position:[0.5,0.5,0.5],start_pos:[0.0,0.0,16.0]}
data modify storage rhythm_axe:maps.easingtest notes append value {id:9,type:3,time:144,note_base_life:16,size:1.0,duration:8,density:8,anim_easing:3,anim_power:3,position:[0.5,0.5,0.5],start_pos:[0.0,0.0,16.0]}
# 混凝土（type 3）：缓出 power=4、duration=4（对照：线性默认 easing=1 在 build_test_map）
data modify storage rhythm_axe:maps.easingtest notes append value {id:10,type:3,time:160,note_base_life:16,size:1.0,duration:4,density:4,anim_easing:2,anim_power:4,position:[0.5,0.5,0.5],start_pos:[0.0,0.0,16.0]}
data modify storage rhythm_axe:maps.easingtest notes append value {id:11,type:3,time:176,note_base_life:16,size:1.0,duration:4,density:4,anim_easing:2,anim_power:4,position:[0.5,0.5,0.5],start_pos:[0.0,0.0,16.0]}
