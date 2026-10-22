# 激光特效：出生后隔 1 刻再动画（与召唤同刻会让插值没有起点 ⇒ 直接跳到终态），8刻结束
scoreboard players add @e[tag=laser] laser_time 1
execute as @e[tag=laser] if score @s laser_time matches 2 run \
    function rhythm_axe:maps/goodworld/laser/animate
execute as @e[tag=laser] if score @s laser_time matches 8 run \
    kill @s

# ── 兜底清场（i ≥ 400 刻）──
# 只为防「队列计时器被打断 ⇒ queue 永不消耗」导致无限自调度；强清 queue 后下面的收工判定必然成立，循环自然终止。
# 400 刻远超任何一轮队列时长（最长 laser_queue_append2512 ≈ 68 刻 + 8 刻寿命）。
scoreboard players add i laser_time 1
execute if score i laser_time matches 400.. run kill @e[tag=laser]
execute if score i laser_time matches 400.. run data remove storage rhythm_axe:laser queue

# ── 收工判定：「队列已发空 且 无存活激光实体」──
# ⚠ 不能改回固定刻数（原为 i==64）：队列总时长 = 各 delay 之和，会随激光段变化。
#   固定 64 刻会在「最后一批刚出生、年龄还没到 8」时就删掉 laser_time 计分板，
#   它们的积分被清空 ⇒ `matches 8` 永不成立 ⇒ kill @s 永不执行
#   ⇒ 特效跑完后残留文字展示实体（亮着不动）。正是本次修复的 bug。
execute unless data storage rhythm_axe:laser queue[0] unless entity @e[tag=laser] run \
    data remove storage rhythm_axe:laser queue
execute unless data storage rhythm_axe:laser queue[0] unless entity @e[tag=laser] run \
    data remove storage rhythm_axe:laser running
execute unless data storage rhythm_axe:laser queue[0] unless entity @e[tag=laser] run \
    scoreboard objectives remove laser_time

# 还有队列任务 或 还有存活激光 → 继续下一刻（两分支互斥，同刻只会排一次；已收工则都不成立，循环终止）
execute if data storage rhythm_axe:laser queue[0] run \
    schedule function rhythm_axe:maps/goodworld/laser/laser_main 1t
execute unless data storage rhythm_axe:laser queue[0] if entity @e[tag=laser] run \
    schedule function rhythm_axe:maps/goodworld/laser/laser_main 1t