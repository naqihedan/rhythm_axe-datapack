# 激光特效：出生后隔 1 刻再动画（与召唤同刻会让插值没有起点 ⇒ 直接跳到终态），8刻结束
scoreboard players add @e[tag=laser] laser_time 1
execute as @e[tag=laser] if score @s laser_time matches 2 run \
    function rhythm_axe:maps/goodworld/laser/animate
execute as @e[tag=laser] if score @s laser_time matches 8 run \
    kill @s

# 循环控制 + 冗余计分板消除
scoreboard players add i laser_time 1
execute unless score i laser_time matches 64 run \
    schedule function rhythm_axe:maps/goodworld/laser/laser_main 1t
execute if score i laser_time matches 64 run \
    data remove storage rhythm_axe:laser queue
execute if score i laser_time matches 64 run \
    data remove storage rhythm_axe:laser running
execute if score i laser_time matches 64 run \
    scoreboard objectives remove laser_time