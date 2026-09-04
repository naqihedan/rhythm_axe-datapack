# 混凝土段③（短/长通用）：头端恒 s/2，len = len_target×(1-ratio)；中心 = s/2 - len/2
# 时长 = end - seg2_end = dur（短）/ 有效寿命（长）；#half_sz/#seg2_end/#L100 由 place_concrete 传入（#L100 已修正流速）
# ★ 缓动用原类型（不镜像，与游玩 seg3 一致；文档"每段保留缓动"）
scoreboard players operation #n display_calc = #playhead editor
scoreboard players operation #n display_calc -= #seg2_end editor
scoreboard players operation #total display_calc = @s editor_n_dur
execute if score @s editor_n_dur > @s editor_n_lt run scoreboard players operation #total display_calc = @s editor_n_lt
execute if score #total display_calc matches ..0 run scoreboard players set #total display_calc 1
# ★ clamp：ph 超过收缩段（time+dur）后 n>total，缓出负底数会爆 len → 停在终点（len=0），防无限拉伸
execute if score #n display_calc > #total display_calc run scoreboard players operation #n display_calc = #total display_calc
scoreboard players operation #power display_calc = @s editor_n_power
scoreboard players operation #easing_type display_calc = @s editor_n_easing
function rhythm_axe:utilization/display_animation/easing/power
# len = len_target×(1-ratio)；#L100 已由 place_concrete 预置为正确全长（修正流速）
scoreboard players operation #tmp2 display_calc = #ratio display_calc
scoreboard players operation #tmp2 display_calc *= -1 const
scoreboard players operation #tmp2 display_calc += 10000 const
scoreboard players operation #L100 editor *= #tmp2 display_calc
scoreboard players operation #L100 editor /= 10000 const
execute if score #L100 editor matches ..0 run scoreboard players set #L100 editor 0
# 中心 = s/2 - len/2
scoreboard players operation #TZ editor = #half_sz editor
scoreboard players operation #tmp editor = #L100 editor
scoreboard players operation #tmp editor /= 2 const
scoreboard players operation #TZ editor -= #tmp editor
data modify entity @s transformation.translation set value [0.0,0.0,0.0]
execute store result entity @s transformation.scale[2] float 0.01 run scoreboard players get #L100 editor
execute store result entity @s transformation.translation[2] float 0.01 run scoreboard players get #TZ editor
