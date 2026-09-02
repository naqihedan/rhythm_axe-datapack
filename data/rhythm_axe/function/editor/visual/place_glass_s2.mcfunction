# 玻璃段②（穿过判定位置继续向前）：ratio2 = easing_mirror(n2, dur)；z = dist×dur/lt×ratio2/10000
# @s = 展示实体；镜像缓动 = 类型 1↔2 互换，3 不变
scoreboard players operation #n display_calc = #playhead editor
scoreboard players operation #n display_calc -= @s editor_n_time
scoreboard players operation #total display_calc = @s editor_n_dur
execute if score #total display_calc matches ..0 run scoreboard players set #total display_calc 1
# ★ 2026-08-26 clamp：ph 超过 time+dur 但音符仍存活（end=time+dur+2）时 ratio 越界 → 停在终点
execute if score #n display_calc > #total display_calc run scoreboard players operation #n display_calc = #total display_calc
scoreboard players operation #power display_calc = @s editor_n_power
scoreboard players operation #easing_type display_calc = @s editor_n_easing
execute if score #easing_type display_calc matches 1 run scoreboard players set #easing_type display_calc 2
execute if score #easing_type display_calc matches 2 run scoreboard players set #easing_type display_calc 1
function rhythm_axe:utilization/display_animation/easing/power
# 终点 end = dist×dur/lt（×100）；translation 只沿局部 z = +end（局部 +z = 运动方向，穿过判定位置）
scoreboard players operation #end100 display_calc = @s editor_n_dist
scoreboard players operation #end100 display_calc *= @s editor_n_dur
execute if score @s editor_n_lt matches 1.. run scoreboard players operation #end100 display_calc /= @s editor_n_lt
scoreboard players operation #end100 display_calc *= #ratio display_calc
scoreboard players operation #end100 display_calc /= 10000 const
# dist=0 → end=0
scoreboard players operation #tz editor = #end100 display_calc
execute unless score @s editor_n_dist matches 1.. run scoreboard players set #tz editor 0
data modify entity @s transformation.translation set value [0.0,0.0,0.0]
execute store result entity @s transformation.translation[2] float 0.01 run scoreboard players get #tz editor
