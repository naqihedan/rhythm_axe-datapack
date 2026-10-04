scoreboard objectives add laser_time dummy "激光特效寿命"
scoreboard objectives setdisplay sidebar laser_time

# 启动计时器（仅当当前空闲，避免重复排程导致双倍触发）
execute unless data storage rhythm_axe:laser running run schedule function rhythm_axe:maps/goodworld/laser/laser_queue_tick 1t
data modify storage rhythm_axe:laser running set value 1b

function rhythm_axe:maps/goodworld/laser/laser_main