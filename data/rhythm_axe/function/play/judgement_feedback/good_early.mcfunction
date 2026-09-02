# 判定反馈组表（M2-H）：按音符 hitsound/hit_particles 组号查表播放音效/粒子 + 执行 hit_events（情况=good_early）
scoreboard players operation #nid play_state = @s note_id
data modify storage rhythm_axe:runtime fb_nid set value 0
execute store result storage rhythm_axe:runtime fb_nid int 1 run scoreboard players get #nid play_state
data modify storage rhythm_axe:runtime fb_hitsound set value 0
execute store result storage rhythm_axe:runtime fb_hitsound int 1 run scoreboard players get @s note_hitsound
data modify storage rhythm_axe:runtime fb_particles set value 0
execute store result storage rhythm_axe:runtime fb_particles int 1 run scoreboard players get @s note_hit_particles
data modify storage rhythm_axe:runtime case_name set value "good_early"
function rhythm_axe:play/feedback/feedback with storage rhythm_axe:runtime

#当前判定计数+1
scoreboard players add good_early play_state 1

#FC/AP标签变更、combo变更
scoreboard players add combo play_state 1
scoreboard players operation max_combo play_state > combo play_state

execute if score fc_ap play_state matches 2 run scoreboard players set fc_ap play_state 1

execute if score feedback_actionbar options matches 1 run title @a actionbar \
    [{"text":"(","color":"red"},\
     {"score":{"objective":"play_state","name":"health"},"color":"red","bold":true},\
     {"text":")","color":"red","bold":true},\
     {"text":"  *  <GOOD   *  ","color":"green"},\
     {"text":"(","color":"white","bold":true},\
     {"score":{"objective":"play_state","name":"combo"},\
     "color":"white","bold":true},\
     {"text":")","color":"white","bold":true}]
execute if score feedback_chat options matches 1 run tellraw @a [{"text":"*  Good *  <","color":"green"}]
