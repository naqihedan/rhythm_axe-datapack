# 判定执行（@s = 音符交互实体；#judge_life = 用于判定的寿命）
# 流程：
#   1. #life = #judge_life → level_from_life 算 #level
#   2. 按 #level 调用反馈函数
#   3. 删除音符对（交互 + 展示，用 note_id 配对）
# 等级：0=bad 1=goodE 2=perfectE 3=perfect 4=perfectL 5=goodL 6=miss

# 换算等级
scoreboard players operation #life play_state = #judge_life play_state
function rhythm_axe:play/judgement/level_from_life
# 诊断（lv.1）：判定瞬间的 note_life（#judge_life）与等级（#level）——定位"判定提前/延后"用（2026-08-08）
#   大P 时 #judge_life=0；若大P 仍落在音符到位前，说明补偿不足；若到位后，说明补偿过头
#   lv.1（不开 lv.2 避免被动画 debug 刷屏，用户 2026-08-08 建议）
execute if score debug_output options matches 1.. run tellraw @a ["",{"text":"[调试.lv1][判定]","color":"gold"},{"text":" id=","color":"gray"},{"score":{"objective":"note_id","name":"@s"}},{"text":" life=","color":"gray"},{"score":{"objective":"play_state","name":"#judge_life"}},{"text":" lv=","color":"gray"},{"score":{"objective":"play_state","name":"#level"}}]

# 按等级调用反馈（@s = 交互实体，保留执行者以便删除）
execute if score #level play_state matches 0 run function rhythm_axe:play/judgement_feedback/bad
execute if score #level play_state matches 1 run function rhythm_axe:play/judgement_feedback/good_early
execute if score #level play_state matches 2 run function rhythm_axe:play/judgement_feedback/perfect_early
execute if score #level play_state matches 3 run function rhythm_axe:play/judgement_feedback/perfect
execute if score #level play_state matches 4 run function rhythm_axe:play/judgement_feedback/perfect_late
execute if score #level play_state matches 5 run function rhythm_axe:play/judgement_feedback/good_late
execute if score #level play_state matches 6 run function rhythm_axe:play/judgement_feedback/miss

# 删除音符对（交互实体 @s + 配对的展示实体 + 判定区域 marker；展示实体兼作完美判定区域代表）
# 先记录 note_id，再杀配对实体
# ★ 先用 note_id 配对打 tag，再 reset+kill：直接 reset 会清掉 note_id，导致后续 kill 配对失效（展示实体残留）
scoreboard players operation #nid play_state = @s note_id
# 清理该音符的 hit_events（判定反馈存储，M2-H）
execute store result storage rhythm_axe:runtime fb_nid int 1 run scoreboard players get #nid play_state
function rhythm_axe:play/feedback/remove_events with storage rhythm_axe:runtime
execute as @e[tag=note_display] if score @s note_id = #nid play_state run tag @s add note_to_clear
# 引导线消失规则（2026-08-29 修订）：
#   仅当当前被判定/清除的音符是 guide 的尾端（note_guide_b）时才清理；
#   前一个音符不再触发强制清理，允许收缩逻辑自然消失。
execute as @e[type=item_display,tag=note_guide] if score @s note_guide_b = #nid play_state run tag @s add note_to_clear
execute as @e[type=marker,tag=note_c_zone] if score @s note_id = #nid play_state run tag @s add note_to_clear
execute as @e[type=marker,tag=note_c_zone_near] if score @s note_id = #nid play_state run tag @s add note_to_clear
execute as @e[type=marker,tag=note_glass_center] if score @s note_id = #nid play_state run tag @s add note_to_clear
tag @s add note_to_clear
# reset 清计分板分数（本版本实体删除不自动清分；note_id 也被清，但已用 tag 配对）
execute as @e[tag=note_to_clear] run scoreboard players reset @s
# kill 用 tag 配对
kill @e[tag=note_to_clear]
