# gcd 递归体（普通函数递归，非宏）：while gd != 0 { t = gn mod gd; gn = gd; gd = t }
# ⚠️ 不能写 return（会砍掉整条调用链）
execute if score #rs_gd editor matches 0 run scoreboard players set #rs_gloop editor 0
execute unless score #rs_gd editor matches 0 run scoreboard players set #rs_gloop editor 1
execute if score #rs_gloop editor matches 1 run scoreboard players operation #rs_gt editor = #rs_gn editor
execute if score #rs_gloop editor matches 1 run scoreboard players operation #rs_gt editor %= #rs_gd editor
execute if score #rs_gloop editor matches 1 run scoreboard players operation #rs_gn editor = #rs_gd editor
execute if score #rs_gloop editor matches 1 run scoreboard players operation #rs_gd editor = #rs_gt editor
execute if score #rs_gloop editor matches 1 run function rhythm_axe:editor/timing/rescale/gcd_loop
