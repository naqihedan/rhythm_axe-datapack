# 普通音符（0/1/2）定位：@s = 展示实体
# ★ 2026-08-26 加缓动（对齐游玩：power≠1 走 easing；power=1 退化为线性，与旧行为一致）
# ratio = easing((playhead-birth)/(time-birth))；tz = -dist×(1-ratio/10000)，到位后 clamp 停 0
scoreboard players operation #n display_calc = #playhead editor
scoreboard players operation #n display_calc -= @s editor_n_birth
scoreboard players operation #total display_calc = @s editor_n_time
scoreboard players operation #total display_calc -= @s editor_n_birth
execute if score #total display_calc matches ..0 run scoreboard players set #total display_calc 1
execute if score #n display_calc > #total display_calc run scoreboard players operation #n display_calc = #total display_calc
scoreboard players operation #power display_calc = @s editor_n_power
scoreboard players operation #easing_type display_calc = @s editor_n_easing
function rhythm_axe:utilization/display_animation/easing/power
# r = 10000 - ratio（出生 ratio=0 → r=10000 → tz=-dist；到位 ratio=10000 → r=0 → tz=0）
scoreboard players operation #r1000 editor = #ratio display_calc
scoreboard players operation #r1000 editor *= -1 const
scoreboard players operation #r1000 editor += 10000 const
scoreboard players operation #tz editor = @s editor_n_dist
scoreboard players operation #tz editor *= #r1000 editor
scoreboard players operation #tz editor /= 10000 const
scoreboard players operation #tz editor *= -1 const
data modify entity @s transformation.translation set value [0.0,0.0,0.0]
execute store result entity @s transformation.translation[2] float 0.01 run scoreboard players get #tz editor
