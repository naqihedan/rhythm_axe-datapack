# play_state 计分板血量减少（血量=0 时不扣、不反馈、不重置冷却）
execute if score damage_cooldown play_state matches ..0 if score health play_state matches 1.. run scoreboard players remove health play_state 1

execute if score damage_cooldown play_state matches ..0 if score health play_state matches 1.. run \
    execute if score feedback_actionbar options matches 1 run title @a actionbar \
    [{"text":"(","color":"red"},\
     {"score":{"objective":"play_state","name":"health"},"color":"red","bold":true},\
     {"text":")","color":"red","bold":true},\
     {"text":"  *    -1 ❤    *  ","color":"red"},\
     {"text":"(","color":"white","bold":true},\
     {"score":{"objective":"play_state","name":"combo"},\
     "color":"white","bold":true},\
     {"text":")","color":"white","bold":true}]

execute if score damage_cooldown play_state matches ..0 if score health play_state matches 1.. run \
    execute if score feedback_chat options matches 1 run tellraw @a [{"text":"*   -1 ❤   *","color":"red"}]


# 判定反馈组表（M2-H）：玻璃撞墙扣血 → damage 情况（音效/粒子 + hit_events.damage）
# 执行者 = 配对的音符交互实体（@s 是玻璃中心 marker，先记录 note_id 再切执行者）
execute if score damage_cooldown play_state matches ..0 if score health play_state matches 1.. run function rhythm_axe:play/feedback/damage_feedback

# 主循环里每刻-1冷却时间直到0，这里不写出
# ★ 冷却来源改为 damage_cooldown（options 设置，改名去掉 glass_；血量=0 时不重置）
execute if score damage_cooldown play_state matches ..0 if score health play_state matches 1.. run scoreboard players operation damage_cooldown play_state = damage_cooldown options

