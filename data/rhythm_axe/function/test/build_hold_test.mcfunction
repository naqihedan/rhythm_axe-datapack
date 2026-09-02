# 构建仅含混凝土 hold 的测试谱面（短 hold + 长 hold，2026-08-09）
# 运行后：function rhythm_axe:play/start_of_game/start_of_game {mapid:"test"}
# ★ 与 build_test_map 保持相同 note_id（12-15 短hold / 18-21 短hold / 26-29 长 hold），
#   便于 concrete/tick 里的临时调试（note_id 12..15）直接生效
# 布局（紧凑版，出生尽量早）：
#   短 hold（duration=8 <= lt=16）判定 time 32/40/48/56（出生 16 起）
#   短 hold（duration=9 <= lt=16）判定 time 72/80/88/96（出生 56 起）
#   长 hold（duration=32 > lt=16）判定 time 128/144/160/176（出生 112 起）
execute if data storage rhythm_axe:maps.test timing_points run data remove storage rhythm_axe:maps.test timing_points
execute if data storage rhythm_axe:maps.test notes run data remove storage rhythm_axe:maps.test notes
execute if data storage rhythm_axe:maps.test events run data remove storage rhythm_axe:maps.test events
data merge storage rhythm_axe:maps.test {id:"test",title:'{"text":"Hold 测试谱面"}',artist:"测试",music:"rhythm_axe:rhythm_axe.audio",health:1000,player_count:1,end_time:240,teleport:0b}

# 时间点
data modify storage rhythm_axe:maps.test timing_points append value {time:0,bpm:15,bpb:4,tpb:8,judgement_scale:1}

# ===== 短 hold（duration=8 <= lt=16）4 方向 =====
#（播报当前测试项目：短hold duration=8，判定 32/40/48/56）
data modify storage rhythm_axe:maps.test events append value {time:15,commands:["tellraw @a [{\"text\":\"[Hold测试] 短hold duration=8 四方向\",\"color\":\"yellow\"}]"]}
data modify storage rhythm_axe:maps.test notes append value {id:12,type:3,time:32,note_base_life:16,size:1.0,duration:8,density:8,anim_easing:1,anim_power:1,position:[0.5,-0.5,0.5],start_pos:[0.0,0.0,16.0]}
data modify storage rhythm_axe:maps.test notes append value {id:13,type:3,time:40,note_base_life:16,size:1.0,duration:8,density:8,anim_easing:1,anim_power:1,position:[0.5,-0.5,0.5],start_pos:[1.0,0.0,16.0]}
data modify storage rhythm_axe:maps.test notes append value {id:14,type:3,time:48,note_base_life:16,size:1.0,duration:8,density:8,anim_easing:1,anim_power:1,position:[0.5,-0.5,0.5],start_pos:[-1.0,0.0,16.0]}
data modify storage rhythm_axe:maps.test notes append value {id:15,type:3,time:56,note_base_life:16,size:1.0,duration:8,density:8,anim_easing:1,anim_power:1,position:[0.5,-0.5,0.5],start_pos:[0.0,-1.0,16.0]}

# ===== 短 hold（duration=9 <= lt=16）4 方向（duration 不能被密度整除的情况）=====
#（播报当前测试项目：短hold duration=9，判定 72/80/88/96）
data modify storage rhythm_axe:maps.test events append value {time:55,commands:["tellraw @a [{\"text\":\"[Hold测试] 短hold duration=9 四方向\",\"color\":\"yellow\"}]"]}
data modify storage rhythm_axe:maps.test notes append value {id:18,type:3,time:72,note_base_life:16,size:1.0,duration:9,density:8,anim_easing:1,anim_power:1,position:[0.5,-0.5,0.5],start_pos:[0.0,0.0,16.0]}
data modify storage rhythm_axe:maps.test notes append value {id:19,type:3,time:80,note_base_life:16,size:1.0,duration:9,density:8,anim_easing:1,anim_power:1,position:[0.5,-0.5,0.5],start_pos:[1.0,0.0,16.0]}
data modify storage rhythm_axe:maps.test notes append value {id:20,type:3,time:88,note_base_life:16,size:1.0,duration:9,density:8,anim_easing:1,anim_power:1,position:[0.5,-0.5,0.5],start_pos:[-1.0,0.0,16.0]}
data modify storage rhythm_axe:maps.test notes append value {id:21,type:3,time:96,note_base_life:16,size:1.0,duration:9,density:8,anim_easing:1,anim_power:1,position:[0.5,-0.5,0.5],start_pos:[0.0,-1.0,16.0]}

# ===== 长 hold（duration=32 > lt=16）4 方向 =====
#（播报当前测试项目：长hold duration=32，判定 128/144/160/176）
data modify storage rhythm_axe:maps.test events append value {time:111,commands:["tellraw @a [{\"text\":\"[Hold测试] 长hold duration=32 四方向\",\"color\":\"yellow\"}]"]}
data modify storage rhythm_axe:maps.test notes append value {id:26,type:3,time:128,note_base_life:16,size:1.0,duration:32,density:8,anim_easing:1,anim_power:1,position:[0.5,-0.5,0.5],start_pos:[0.0,0.0,16.0]}
data modify storage rhythm_axe:maps.test notes append value {id:27,type:3,time:144,note_base_life:16,size:1.0,duration:32,density:8,anim_easing:1,anim_power:1,position:[0.5,-0.5,0.5],start_pos:[1.0,0.0,16.0]}
data modify storage rhythm_axe:maps.test notes append value {id:28,type:3,time:160,note_base_life:16,size:1.0,duration:32,density:8,anim_easing:1,anim_power:1,position:[0.5,-0.5,0.5],start_pos:[-1.0,0.0,16.0]}
data modify storage rhythm_axe:maps.test notes append value {id:29,type:3,time:176,note_base_life:16,size:1.0,duration:32,density:8,anim_easing:1,anim_power:1,position:[0.5,-0.5,0.5],start_pos:[0.0,-1.0,16.0]}

tellraw @a [{"text":"Hold 测试谱面已构建！开始游玩：","color":"yellow"},{"text":"/function rhythm_axe:play/start_of_game/start_of_game {mapid:\"test\"}","color":"green"}]
