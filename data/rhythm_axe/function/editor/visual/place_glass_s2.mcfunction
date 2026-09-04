# 玻璃段②（穿过判定位置继续向前）：ratio2 = easing_mirror(n2, dur)；z = dist×dur/lt×ratio2/10000
# @s = 展示实体；镜像缓动 = 类型 1↔2 互换，3 不变
scoreboard players operation #n display_calc = #playhead editor
scoreboard players operation #n display_calc -= @s editor_n_time
# ★ 2026-09-04 修复"最后少走一格/倒数第二格停两刻"：total = 后段实际存活帧数 = end-time（D+1），
#   使终点在最后一个存活帧由真实位移走到、下一帧出窗；而非用 editor_n_dur(=D) 导致末帧提前饱和、
#   终点由 clamp 帧"贴"上（最后一格没走进、卡倒数第二格 2 帧）。dur=0 时 total=1，停在判定位置一帧后消失。
scoreboard players operation #total display_calc = @s editor_n_end
scoreboard players operation #total display_calc -= @s editor_n_time
execute if score #total display_calc matches ..0 run scoreboard players set #total display_calc 1
# clamp：ph 超过 total（end 帧后）时 ratio 越界 → 停在终点
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
