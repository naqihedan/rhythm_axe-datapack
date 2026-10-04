# 掷一个叉号候选点 + 禁区判定（禁区 = XY 矩形 x∈[-2.5,-0.5]、y∈[0.5,1.5]，×1000 口径）
# 未撞禁区 → 交给 cross_emit 召唤；撞禁区且重掷次数没用完 → 自递归再掷（最多 8 次，之后放弃这一个）
# ★ 顺序要点：召唤判定必须排在【重掷那一行之前】——重掷会改写 #cr_bad/#cr_x/#cr_y（共享临时分数），
#   外层帧回来后不能再依据它们做判断；所以重掷必须是本函数最后一行、外层帧在它之前已做完自己的事
execute store result score #cr_x cross_time run random value -4000..0
execute store result score #cr_y cross_time run random value 0..2000

# 禁区判定：#cr_bad=1 表示这次掷到的 (x,y) 落在矩形里
scoreboard players set #cr_bad cross_time 0
execute if score #cr_x cross_time matches -2500..-500 if score #cr_y cross_time matches 500..1500 run scoreboard players set #cr_bad cross_time 1

# 未撞禁区 → 本帧就地召唤
execute if score #cr_bad cross_time matches 0 run function rhythm_axe:maps/goodworld/laser/cross_emit

# 撞禁区 → 重掷（★ 必须留在最后一行）
scoreboard players add #cr_try cross_time 1
execute if score #cr_bad cross_time matches 1 if score #cr_try cross_time matches ..8 run function rhythm_axe:maps/goodworld/laser/cross_fire_roll
