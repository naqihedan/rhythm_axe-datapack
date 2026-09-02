# 每 tick 的 tick 反馈（@s = 音符交互实体，note_moving=1；active_note 每 tick 调用）
# 与 spawn 同机制：重设 fb_*，case_name="tick"，走 feedback 查表链（音效/粒子/hit_events 的 tick 情况）
# 位置 = 交互实体（调用方已 at @s）
data modify storage rhythm_axe:runtime fb_hitsound set value 0
execute store result storage rhythm_axe:runtime fb_hitsound int 1 run scoreboard players get @s note_hitsound
data modify storage rhythm_axe:runtime fb_particles set value 0
execute store result storage rhythm_axe:runtime fb_particles int 1 run scoreboard players get @s note_hit_particles
execute store result storage rhythm_axe:runtime fb_nid int 1 run scoreboard players get @s note_id
data modify storage rhythm_axe:runtime case_name set value "tick"
function rhythm_axe:play/feedback/feedback with storage rhythm_axe:runtime
