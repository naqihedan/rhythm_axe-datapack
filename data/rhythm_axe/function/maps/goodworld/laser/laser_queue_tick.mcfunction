# 激光延时队列的「计时器」：每刻只给「队首」倒计时，归零就发射。
# 为什么这样写：schedule 不能给宏函数传参，只能让普通中转函数到点自己用 with storage 取 storage 里的快照。
# 数据：storage rhythm_axe:laser
#   queue[] = 待发射任务，元素 {delay:int, x:float, angle:float}
#   running = 1b 表示计时器已在跑（防止重复 schedule 导致双倍触发）

# 队列空 → 清 running 标记并收工（不再自调度）
execute unless data storage rhythm_axe:laser queue[0] run data remove storage rhythm_axe:laser running
execute unless data storage rhythm_axe:laser queue[0] run return 0

# 队首 delay 减 1（data 不能做算术，借计分板中转）
scoreboard players set #q laser_time 0
execute store result score #q laser_time run data get storage rhythm_axe:laser queue[0].delay
scoreboard players remove #q laser_time 1
execute store result storage rhythm_axe:laser queue[0].delay int 1 run scoreboard players get #q laser_time

# 到点 → 发射并弹出
execute if score #q laser_time matches ..0 run \
    function rhythm_axe:maps/goodworld/laser/laser_queue_fire

# 继续下一刻
schedule function rhythm_axe:maps/goodworld/laser/laser_queue_tick 1t
