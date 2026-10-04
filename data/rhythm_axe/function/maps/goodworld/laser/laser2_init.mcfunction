# 激光2 入口：8 波 × 8 刻（共 64 刻）
scoreboard objectives add laser2_time dummy "激光2寿命"
scoreboard players set #l2_shot laser2_time 0
function rhythm_axe:maps/goodworld/laser/laser2_main
