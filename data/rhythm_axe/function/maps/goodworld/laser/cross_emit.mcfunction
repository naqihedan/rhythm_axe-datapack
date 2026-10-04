# 落地召唤一个叉号（读 cross_fire_roll 已掷好的 #cr_x/#cr_y；大小在此掷）
# ⚠️ 键名必须与 cross_summon 的 $(x)$(y)$(s) 一致，否则宏缺参数、召唤静默失败
execute store result score #cr_s cross_time run random value 500..2000
execute store result storage rhythm_axe:prop x float 0.001 run scoreboard players get #cr_x cross_time
execute store result storage rhythm_axe:prop y float 0.001 run scoreboard players get #cr_y cross_time
execute store result storage rhythm_axe:prop s float 0.001 run scoreboard players get #cr_s cross_time
function rhythm_axe:maps/goodworld/laser/cross_summon with storage rhythm_axe:prop
data remove storage rhythm_axe:prop x
data remove storage rhythm_axe:prop y
data remove storage rhythm_axe:prop s
