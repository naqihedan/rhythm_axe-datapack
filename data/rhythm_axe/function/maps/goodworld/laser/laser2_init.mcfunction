# 激光2 入口：8 波 × 8 刻（共 64 刻）
scoreboard objectives add laser2_time dummy "激光2寿命"
# 硬重置：清掉上一轮可能残留下来的实体（否则会混进这一批）
kill @e[tag=laser2]
scoreboard players set #l2_shot laser2_time 0
function rhythm_axe:maps/goodworld/laser/laser2_main
