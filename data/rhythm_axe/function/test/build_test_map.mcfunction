# 构建测试谱面（手动测试用）
# 运行后：function rhythm_axe:play/start_of_game/start_of_game {mapid:"test"}
# 1.21.5+ 空路径不可用：逐键清空（if data 保护避免报错）+ merge 覆盖根
# （merge 直接合并到根，无需路径）
execute if data storage rhythm_axe:maps.test timing_points run data remove storage rhythm_axe:maps.test timing_points
execute if data storage rhythm_axe:maps.test notes run data remove storage rhythm_axe:maps.test notes
execute if data storage rhythm_axe:maps.test events run data remove storage rhythm_axe:maps.test events
data merge storage rhythm_axe:maps.test {id:"test",title:'测试谱面',artist:"测试",music:"rhythm_axe:rhythm_axe.audio",health:1000,player_count:1,end_time:560,teleport:0b}

# 时间点
data modify storage rhythm_axe:maps.test timing_points append value {time:0,bpm:150,bpb:4,tpb:8,judgement_scale:1}

## 线性运动
#  音符盒，直线+3种斜线
#（播报当前测试项目：音符盒线性直线+3种斜线，出生 -16）
data modify storage rhythm_axe:maps.test events append value {time:-16,commands:["tellraw @a [{\"text\":\"[测试] 音符盒：直线+3种斜线（size 1/2/0.5/0.1）\",\"color\":\"yellow\"}]"]}
data modify storage rhythm_axe:maps.test notes append value {id:0,type:0,time:0,note_base_life:16,size:1.0,anim_easing:1,anim_power:1,position:[0.5,0.5,0.5],start_pos:[0.0,0.0,16.0]}
data modify storage rhythm_axe:maps.test notes append value {id:1,type:0,time:16,note_base_life:16,size:2.0,anim_easing:1,anim_power:1,position:[0.5,0.5,0.5],start_pos:[1.0,0.0,16.0]}
data modify storage rhythm_axe:maps.test notes append value {id:2,type:0,time:32,note_base_life:16,size:0.5,anim_easing:1,anim_power:1,position:[0.5,0.5,0.5],start_pos:[-1.0,0.0,16.0]}
data modify storage rhythm_axe:maps.test notes append value {id:3,type:0,time:48,note_base_life:16,size:0.1,anim_easing:1,anim_power:1,position:[0.5,0.5,0.5],start_pos:[0.0,-1.0,16.0]}
# 木板
#（播报当前测试项目：木板线性直线+3种斜线，出生 48）
data modify storage rhythm_axe:maps.test events append value {time:48,commands:["tellraw @a [{\"text\":\"[测试] 木板：直线+3种斜线（size 1/2/0.5/0.1）\",\"color\":\"yellow\"}]"]}
data modify storage rhythm_axe:maps.test notes append value {id:4,type:1,time:64,note_base_life:16,size:1.0,anim_easing:1,anim_power:1,position:[0.5,0.5,0.5],start_pos:[0.0,0.0,16.0]}
data modify storage rhythm_axe:maps.test notes append value {id:5,type:1,time:80,note_base_life:16,size:2.0,anim_easing:1,anim_power:1,position:[0.5,0.5,0.5],start_pos:[1.0,0.0,16.0]}
data modify storage rhythm_axe:maps.test notes append value {id:6,type:1,time:96,note_base_life:16,size:0.5,anim_easing:1,anim_power:1,position:[0.5,0.5,0.5],start_pos:[-1.0,0.0,16.0]}
data modify storage rhythm_axe:maps.test notes append value {id:7,type:1,time:112,note_base_life:16,size:0.1,anim_easing:1,anim_power:1,position:[0.5,0.5,0.5],start_pos:[0.0,-1.0,16.0]}
# 唱片机
#（播报当前测试项目：唱片机线性直线+3种斜线，出生 112）
data modify storage rhythm_axe:maps.test events append value {time:112,commands:["tellraw @a [{\"text\":\"[测试] 唱片机：直线+3种斜线（size 1/2/0.5/0.1）\",\"color\":\"yellow\"}]"]}
data modify storage rhythm_axe:maps.test notes append value {id:8,type:2,time:128,note_base_life:16,size:1.0,anim_easing:1,anim_power:1,position:[0.5,0.5,0.5],start_pos:[0.0,0.0,16.0]}
data modify storage rhythm_axe:maps.test notes append value {id:9,type:2,time:144,note_base_life:16,size:2.0,anim_easing:1,anim_power:1,position:[0.5,0.5,0.5],start_pos:[1.0,0.0,16.0]}
data modify storage rhythm_axe:maps.test notes append value {id:10,type:2,time:160,note_base_life:16,size:0.5,anim_easing:1,anim_power:1,position:[0.5,0.5,0.5],start_pos:[-1.0,0.0,16.0]}
data modify storage rhythm_axe:maps.test notes append value {id:11,type:2,time:176,note_base_life:16,size:0.1,anim_easing:1,anim_power:1,position:[0.5,0.5,0.5],start_pos:[0.0,-1.0,16.0]}
# 混凝土
# 寿命 > 持续时间 不同密度
#（播报当前测试项目：混凝土 寿命>持续时间 密度 8/4/2/1，出生 176）
data modify storage rhythm_axe:maps.test events append value {time:176,commands:["tellraw @a [{\"text\":\"[测试] 混凝土：寿命>持续时间，密度 8/4/2/1\",\"color\":\"yellow\"}]"]}
data modify storage rhythm_axe:maps.test notes append value {id:12,type:3,time:192,note_base_life:16,size:1.0,duration:8,density:8,anim_easing:1,anim_power:1,position:[0.5,-0.4,0.5],start_pos:[0.0,0.0,16.0]}
data modify storage rhythm_axe:maps.test notes append value {id:13,type:3,time:208,note_base_life:16,size:1.0,duration:8,density:4,anim_easing:1,anim_power:1,position:[0.5,-0.4,0.5],start_pos:[1.0,0.0,16.0]}
data modify storage rhythm_axe:maps.test notes append value {id:14,type:3,time:224,note_base_life:16,size:1.0,duration:8,density:2,anim_easing:1,anim_power:1,position:[0.5,-0.4,0.5],start_pos:[-1.0,0.0,16.0]}
data modify storage rhythm_axe:maps.test notes append value {id:15,type:3,time:240,note_base_life:16,size:1.0,duration:8,density:1,anim_easing:1,anim_power:1,position:[0.5,-0.4,0.5],start_pos:[0.0,-1.0,16.0]}
# 寿命 < 持续时间，垂直下落（xz平面上移动距离<=1）
#（播报当前测试项目：混凝土 寿命<持续时间 垂直下落，出生 240）
data modify storage rhythm_axe:maps.test events append value {time:239,commands:["tellraw @a [{\"text\":\"[测试] 混凝土：寿命<持续时间，垂直下落\",\"color\":\"yellow\"}]"]}
data modify storage rhythm_axe:maps.test notes append value {id:16,type:3,time:256,note_base_life:16,size:1.0,duration:20,density:8,anim_easing:1,anim_power:1,position:[0.5,0.5,0.5],start_pos:[0.0,16.0,0.0]}
#data modify storage rhythm_axe:maps.test notes append value {id:17,type:3,time:288,note_base_life:16,size:1.0,duration:20,density:8,anim_easing:1,anim_power:1,position:[0.5,0.5,0.5],start_pos:[0.0,16.0,0.0]}
# 持续时间不能被密度整除（id 18-21 避开 12-15，time 320 起避开垂直下落）
#（播报当前测试项目：混凝土 持续时间不能被密度整除，出生 304）
data modify storage rhythm_axe:maps.test events append value {time:304,commands:["tellraw @a [{\"text\":\"[测试] 混凝土：持续时间不能被密度整除\",\"color\":\"yellow\"}]"]}
data modify storage rhythm_axe:maps.test notes append value {id:18,type:3,time:320,note_base_life:16,size:1.0,duration:9,density:8,anim_easing:1,anim_power:1,position:[0.5,-0.5,0.5],start_pos:[0.0,0.0,16.0]}
data modify storage rhythm_axe:maps.test notes append value {id:19,type:3,time:336,note_base_life:16,size:1.0,duration:9,density:8,anim_easing:1,anim_power:1,position:[0.5,-0.5,0.5],start_pos:[1.0,0.0,16.0]}
data modify storage rhythm_axe:maps.test notes append value {id:20,type:3,time:352,note_base_life:16,size:1.0,duration:9,density:8,anim_easing:1,anim_power:1,position:[0.5,-0.5,0.5],start_pos:[-1.0,0.0,16.0]}
data modify storage rhythm_axe:maps.test notes append value {id:21,type:3,time:368,note_base_life:16,size:1.0,duration:9,density:8,anim_easing:1,anim_power:1,position:[0.5,-0.5,0.5],start_pos:[0.0,-1.0,16.0]}
# 长 hold（duration > note_base_life，第二模型：头动 lt → 中间静止 → 尾动 lt；2026-08-09 新加）
#（播报当前测试项目：混凝土 长hold duration>note_base_life 4 方向，出生 384）
data modify storage rhythm_axe:maps.test events append value {time:384,commands:["tellraw @a [{\"text\":\"[测试] 混凝土：长hold（duration>note_base_life）\",\"color\":\"yellow\"}]"]}
data modify storage rhythm_axe:maps.test notes append value {id:26,type:3,time:400,note_base_life:16,size:1.0,duration:32,density:8,anim_easing:1,anim_power:1,position:[0.5,-0.4,0.5],start_pos:[0.0,0.0,16.0]}
data modify storage rhythm_axe:maps.test notes append value {id:27,type:3,time:416,note_base_life:16,size:1.0,duration:32,density:8,anim_easing:1,anim_power:1,position:[0.5,-0.4,0.5],start_pos:[1.0,0.0,16.0]}
data modify storage rhythm_axe:maps.test notes append value {id:28,type:3,time:432,note_base_life:16,size:1.0,duration:32,density:8,anim_easing:1,anim_power:1,position:[0.5,-0.4,0.5],start_pos:[-1.0,0.0,16.0]}
data modify storage rhythm_axe:maps.test notes append value {id:29,type:3,time:448,note_base_life:16,size:1.0,duration:32,density:8,anim_easing:1,anim_power:1,position:[0.5,-0.4,0.5],start_pos:[0.0,-1.0,16.0]}
# 染色玻璃（id 30-33，time 464 起）
#（播报当前测试项目：染色玻璃线性 4 方向，出生 448）
data modify storage rhythm_axe:maps.test events append value {time:448,commands:["tellraw @a [{\"text\":\"[测试] 染色玻璃：4 方向\",\"color\":\"yellow\"}]"]}
data modify storage rhythm_axe:maps.test notes append value {id:30,type:4,time:464,note_base_life:16,size:1.0,anim_easing:1,anim_power:1,position:[0.5,0.5,0.5],start_pos:[0.0,0.0,16.0]}
data modify storage rhythm_axe:maps.test notes append value {id:31,type:4,time:480,note_base_life:16,size:1.0,anim_easing:1,anim_power:1,position:[0.5,0.5,0.5],start_pos:[1.0,0.0,16.0]}
data modify storage rhythm_axe:maps.test notes append value {id:32,type:4,time:496,note_base_life:16,size:1.0,anim_easing:1,anim_power:1,position:[0.5,0.5,0.5],start_pos:[-1.0,0.0,16.0]}
data modify storage rhythm_axe:maps.test notes append value {id:33,type:4,time:512,note_base_life:16,size:1.0,anim_easing:1,anim_power:1,position:[0.5,0.5,0.5],start_pos:[0.0,1.0,16.0]}
## 缓动（全部走直线）
# 音符盒，
#（这里有一条播报当前测试项目的事件）
# 木板
#（这里有一条播报当前测试项目的事件）
# 唱片机
#（这里有一条播报当前测试项目的事件）
# 混凝土
#（这里有一条播报当前测试项目的事件）
# 染色玻璃
#（这里有一条播报当前测试项目的事件）

## 多音符同时判定（全部走直线）
# 音符盒
#（这里有一条播报当前测试项目的事件）
# 木板
#（这里有一条播报当前测试项目的事件）
# 唱片机
#（这里有一条播报当前测试项目的事件）
# 混凝土
#（这里有一条播报当前测试项目的事件）
# 染色玻璃
#（这里有一条播报当前测试项目的事件）

## 击打事件测试（全部走直线）
# 音符盒，仅spawn，2个
#（这里有一条播报当前测试项目的事件）
# 音符盒，聊天栏判定反馈（good判定一组，perfect判定一组，bad/miss一组），6个
#（这里有一条播报当前测试项目的事件）
# 玻璃，damage判定
#（这里有一条播报当前测试项目的事件）












tellraw @a [{"text":"测试谱面已构建！开始游玩：","color":"yellow"},{"text":"/function rhythm_axe:play/start_of_game/start_of_game {mapid:\"test\"}","color":"green"}]
