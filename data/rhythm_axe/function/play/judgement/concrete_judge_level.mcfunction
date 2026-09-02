# 混凝土按指定寿命判级（@s = 混凝土交互实体；#judge_life = 判级用寿命）
# 用于判定保护：首段过早离开→按记录寿命（正）；末段过短延长→按 l+duration（负）
# 只反馈判级并标记本段完成，不杀实体（混凝土多段继续）
scoreboard players operation #life play_state = #judge_life play_state
function rhythm_axe:play/judgement/level_from_life
execute if score #level play_state matches 0 run function rhythm_axe:play/judgement_feedback/bad
execute if score #level play_state matches 1 run function rhythm_axe:play/judgement_feedback/good_early
execute if score #level play_state matches 2 run function rhythm_axe:play/judgement_feedback/perfect_early
execute if score #level play_state matches 3 run function rhythm_axe:play/judgement_feedback/perfect
execute if score #level play_state matches 4 run function rhythm_axe:play/judgement_feedback/perfect_late
execute if score #level play_state matches 5 run function rhythm_axe:play/judgement_feedback/good_late
execute if score #level play_state matches 6 run function rhythm_axe:play/judgement_feedback/miss
scoreboard players set @s note_c_seg_done 1
