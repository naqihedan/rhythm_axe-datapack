# title1680 每 8 刻驱动器：平移 +0.25 格（3/(96/8)，共 12 步 = 96 刻）+ 同步更新文字透明度
# 为什么合并到同一函数：display 的可插值字段（transformation / text_opacity …）**共享同一条插值时间线**，
#   分开下发会被彼此的 interpolation_duration 抹平（这正是「透明度看着单调变化」的根因）。
#   ⇒ 平移与透明度必须在**同一次更新**里、带同一个 interpolation_duration:8。
# 实体被清掉后自动停链（不再自调度）。
execute unless entity @e[tag=title1680] run return 0
scoreboard players set #t1680_4 title1680_time 4
scoreboard players add #t1680_p title1680_time 1

# 平移：第 p 步 → translation.x = 0.25 × p
execute store result storage rhythm_axe:prop tx float 0.25 run scoreboard players get #t1680_p title1680_time
execute as @e[tag=title1680] run data modify entity @s transformation.translation[0] set from storage rhythm_axe:prop tx
data remove storage rhythm_axe:prop tx

# 透明度：4 档 = 32 刻一循环（128 → 80 → 32 → 80）
scoreboard players operation #t1680_m title1680_time = #t1680_p title1680_time
scoreboard players operation #t1680_m title1680_time %= #t1680_4 title1680_time
execute if score #t1680_m title1680_time matches 1 run execute as @e[tag=title1680] run data modify entity @s text_opacity set value 128
execute if score #t1680_m title1680_time matches 2 run execute as @e[tag=title1680] run data modify entity @s text_opacity set value 80
execute if score #t1680_m title1680_time matches 3 run execute as @e[tag=title1680] run data modify entity @s text_opacity set value 32
execute if score #t1680_m title1680_time matches 0 run execute as @e[tag=title1680] run data modify entity @s text_opacity set value 80

# 插值 8 刻；必须显式带 start_interpolation:0（不带会沿用上一次的时间，越抹越糊）
execute as @e[tag=title1680] run data merge entity @s {interpolation_duration:8,start_interpolation:0}

# 12 步走完（t = 8…96）就停
execute unless score #t1680_p title1680_time matches 12.. run schedule function rhythm_axe:maps/goodworld/title1680_move 8t
