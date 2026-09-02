# 玻璃段①（出生→判定）：ratio = easing(n1,total1)；z = -dist×(10000-ratio)/10000
# @s = 展示实体；缓动类型/幂次从实体计分板读
scoreboard players operation #n display_calc = #playhead editor
scoreboard players operation #n display_calc -= @s editor_n_birth
scoreboard players operation #total display_calc = @s editor_n_time
scoreboard players operation #total display_calc -= @s editor_n_birth
execute if score #total display_calc matches ..0 run scoreboard players set #total display_calc 1
scoreboard players operation #power display_calc = @s editor_n_power
scoreboard players operation #easing_type display_calc = @s editor_n_easing
function rhythm_axe:utilization/display_animation/easing/power
# ★ 2026-08-26 修复：translation 只沿局部 z = -dist×(10000-ratio)/10000（同 place_linear 理由）
scoreboard players operation #r10000 display_calc = #ratio display_calc
scoreboard players operation #r10000 display_calc *= -1 const
scoreboard players operation #r10000 display_calc += 10000 const
scoreboard players operation #tz editor = @s editor_n_dist
scoreboard players operation #tz editor *= #r10000 display_calc
scoreboard players operation #tz editor /= 10000 const
scoreboard players operation #tz editor *= -1 const
data modify entity @s transformation.translation set value [0.0,0.0,0.0]
execute store result entity @s transformation.translation[2] float 0.01 run scoreboard players get #tz editor
