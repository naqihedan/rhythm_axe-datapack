# 混凝土段①（短/长通用）：头动尾停拉伸。尾端恒 = -s/2-d；len = len_target×easing；中心 = 尾端+len/2
# 时长 = seg1_end - birth = min(dur,lt)；#half_sz/#seg1_end 由 place_concrete 传入
scoreboard players operation #n display_calc = #playhead editor
scoreboard players operation #n display_calc -= @s editor_n_birth
scoreboard players operation #total display_calc = #seg1_end editor
scoreboard players operation #total display_calc -= @s editor_n_birth
execute if score #total display_calc matches ..0 run scoreboard players set #total display_calc 1
scoreboard players operation #power display_calc = @s editor_n_power
scoreboard players operation #easing_type display_calc = @s editor_n_easing
function rhythm_axe:utilization/display_animation/easing/power
# len = len_target×ratio（×100）
scoreboard players operation #L100 editor = @s editor_n_len
scoreboard players operation #L100 editor *= #ratio display_calc
scoreboard players operation #L100 editor /= 10000 const
# 中心 = (-s/2-d) + len/2（尾端起点往回退 size/2 = -s/2-d）
scoreboard players operation #TZ editor = #half_sz editor
scoreboard players operation #TZ editor *= -1 const
scoreboard players operation #TZ editor -= @s editor_n_dist
scoreboard players operation #tmp editor = #L100 editor
scoreboard players operation #tmp editor /= 2 const
scoreboard players operation #TZ editor += #tmp editor
data modify entity @s transformation.translation set value [0.0,0.0,0.0]
execute store result entity @s transformation.scale[2] float 0.01 run scoreboard players get #L100 editor
execute store result entity @s transformation.translation[2] float 0.01 run scoreboard players get #TZ editor
