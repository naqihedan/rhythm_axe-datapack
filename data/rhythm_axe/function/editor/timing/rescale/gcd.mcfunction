# 欧几里得约分：#rs_num / #rs_den → 约到最简（两者需 > 0）
# 用途：把 tps 比值（可能是 1 800 000 / 1 200 000 这种）压到 3/2，
#   否则 scale 里的 r×num 会溢出 int32。
scoreboard players operation #rs_gn editor = #rs_num editor
scoreboard players operation #rs_gd editor = #rs_den editor
function rhythm_axe:editor/timing/rescale/gcd_loop
execute if score #rs_gn editor matches 1.. run scoreboard players operation #rs_num editor /= #rs_gn editor
execute if score #rs_gn editor matches 1.. run scoreboard players operation #rs_den editor /= #rs_gn editor