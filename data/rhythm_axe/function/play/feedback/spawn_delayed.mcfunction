# 延迟到"开始移动"那一刻的 spawn 反馈（@s = 音符交互实体；note_spawn_delay 归 0 且 note_moving=0 时由 active_note 调用）
# 从实体计分板恢复 fb_*（hitsound/particles/note_id；hit_events 已按 note_id 存于 runtime，且音符未清除）
# 位置 = 交互实体（调用方已 at @s）；走 feedback 同一查表链（音效/粒子/hit_events 的 spawn 情况）
data modify storage rhythm_axe:runtime fb_hitsound set value 0
execute store result storage rhythm_axe:runtime fb_hitsound int 1 run scoreboard players get @s note_hitsound
data modify storage rhythm_axe:runtime fb_particles set value 0
execute store result storage rhythm_axe:runtime fb_particles int 1 run scoreboard players get @s note_hit_particles
execute store result storage rhythm_axe:runtime fb_nid int 1 run scoreboard players get @s note_id
data modify storage rhythm_axe:runtime case_name set value "spawn"
function rhythm_axe:play/feedback/feedback with storage rhythm_axe:runtime
# ★ 标记已开始运动 + spawn 已触发（防每刻重放）
scoreboard players set @s note_moving 1
scoreboard players set @s note_spawn_delay -1
