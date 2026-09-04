# 混凝土段②：短 hold 整体平移（头端 -s/2-d+len1 → s/2，len 恒 len1）；长 hold 静止（中心=s/2-len/2，len=d+s）
# 短 hold（dur<=有效寿命）：平移；#half_sz/#seg1_end/#seg2_end/#L100 由 place_concrete 传入（#L100 已修正流速）
execute if score @s editor_n_dur <= @s editor_n_lt run scoreboard players operation #n display_calc = #playhead editor
execute if score @s editor_n_dur <= @s editor_n_lt run scoreboard players operation #n display_calc -= #seg1_end editor
execute if score @s editor_n_dur <= @s editor_n_lt run scoreboard players operation #total display_calc = #seg2_end editor
execute if score @s editor_n_dur <= @s editor_n_lt run scoreboard players operation #total display_calc -= #seg1_end editor
execute if score @s editor_n_dur <= @s editor_n_lt if score #total display_calc matches ..0 run scoreboard players set #total display_calc 1
execute if score @s editor_n_dur <= @s editor_n_lt run scoreboard players operation #power display_calc = @s editor_n_power
execute if score @s editor_n_dur <= @s editor_n_lt run scoreboard players operation #easing_type display_calc = @s editor_n_easing
execute if score @s editor_n_dur <= @s editor_n_lt run function rhythm_axe:utilization/display_animation/easing/power
# 短 hold：头端 = (-s/2-d+len1) + (d+s-len1)×ratio；中心 = 头端 - len1/2
execute if score @s editor_n_dur <= @s editor_n_lt run scoreboard players operation #head editor = #half_sz editor
execute if score @s editor_n_dur <= @s editor_n_lt run scoreboard players operation #head editor *= -1 const
execute if score @s editor_n_dur <= @s editor_n_lt run scoreboard players operation #head editor -= @s editor_n_dist
execute if score @s editor_n_dur <= @s editor_n_lt run scoreboard players operation #head editor += #L100 editor
execute if score @s editor_n_dur <= @s editor_n_lt run scoreboard players operation #tmp editor = @s editor_n_dist
execute if score @s editor_n_dur <= @s editor_n_lt run scoreboard players operation #tmp editor += #half_sz editor
execute if score @s editor_n_dur <= @s editor_n_lt run scoreboard players operation #tmp editor += #half_sz editor
execute if score @s editor_n_dur <= @s editor_n_lt run scoreboard players operation #tmp editor -= #L100 editor
execute if score @s editor_n_dur <= @s editor_n_lt run scoreboard players operation #tmp editor *= #ratio display_calc
execute if score @s editor_n_dur <= @s editor_n_lt run scoreboard players operation #tmp editor /= 10000 const
execute if score @s editor_n_dur <= @s editor_n_lt run scoreboard players operation #head editor += #tmp editor
execute if score @s editor_n_dur <= @s editor_n_lt run scoreboard players operation #TZ editor = #head editor
execute if score @s editor_n_dur <= @s editor_n_lt run scoreboard players operation #tmp editor = #L100 editor
execute if score @s editor_n_dur <= @s editor_n_lt run scoreboard players operation #tmp editor /= 2 const
execute if score @s editor_n_dur <= @s editor_n_lt run scoreboard players operation #TZ editor -= #tmp editor
# 长 hold（dur>lt）：静止，中心 = s/2 - len/2（len=d+s），len 恒定
execute if score @s editor_n_dur > @s editor_n_lt run scoreboard players operation #TZ editor = #half_sz editor
execute if score @s editor_n_dur > @s editor_n_lt run scoreboard players operation #tmp editor = #L100 editor
execute if score @s editor_n_dur > @s editor_n_lt run scoreboard players operation #tmp editor /= 2 const
execute if score @s editor_n_dur > @s editor_n_lt run scoreboard players operation #TZ editor -= #tmp editor
data modify entity @s transformation.translation set value [0.0,0.0,0.0]
execute store result entity @s transformation.scale[2] float 0.01 run scoreboard players get #L100 editor
execute store result entity @s transformation.translation[2] float 0.01 run scoreboard players get #TZ editor
