# 玻璃撞墙扣血的判定反馈（@s = 玻璃中心 marker；由 judgement_feedback/damage 在扣血成功时调用）
# 从配对的音符交互实体读取组号，以交互实体为执行者触发 feedback（case_name="damage"）
# 执行者 = 音符交互实体，位置 = 交互实体位置
scoreboard players operation #nid play_state = @s note_id
data modify storage rhythm_axe:runtime fb_nid set value 0
execute store result storage rhythm_axe:runtime fb_nid int 1 run scoreboard players get #nid play_state
data modify storage rhythm_axe:runtime fb_hitsound set value 0
# ★ 修复（2026-08-08 用户实测：多玻璃时 x=4.5 玻璃扣血无音效/粒子）：原 limit=1 只检查第一个玻璃交互实体，
#   note_id 不匹配即静默跳过（不找第二个）→ 多个玻璃共存时只有实体顺序靠前的那组有反馈。
#   去掉 limit=1 遍历所有玻璃交互实体，note_id 唯一 → 仅匹配的那个执行
execute as @e[type=interaction,tag=note_stained_glass] if score @s note_id = #nid play_state run execute store result storage rhythm_axe:runtime fb_hitsound int 1 run scoreboard players get @s note_hitsound
data modify storage rhythm_axe:runtime fb_particles set value 0
execute as @e[type=interaction,tag=note_stained_glass] if score @s note_id = #nid play_state run execute store result storage rhythm_axe:runtime fb_particles int 1 run scoreboard players get @s note_hit_particles
data modify storage rhythm_axe:runtime case_name set value "damage"
# 以交互实体为执行者调 feedback（位置 = 交互实体位置）
execute as @e[type=interaction,tag=note_stained_glass] if score @s note_id = #nid play_state at @s run function rhythm_axe:play/feedback/feedback with storage rhythm_axe:runtime
