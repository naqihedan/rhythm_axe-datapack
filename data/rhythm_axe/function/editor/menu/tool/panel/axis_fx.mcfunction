# 轴锁定开关"打开"时的提示粒子（面板 23）：在**该轴的固定坐标平面**上撒 dust。
#   生成点 = 玩家位置，把该轴坐标改成锁定值；散布只在另两轴（该轴 delta = 0）⇒ 粒子被限制在一个平面上。
#   前置：#fx_axis editor = 0(X 红) / 1(Y 绿) / 2(Z 淡蓝)
execute at @s run summon marker ~ ~ ~ {Tags:["editor_axis_fx"]}
execute if score #fx_axis editor matches 0 run execute store result entity @e[tag=editor_axis_fx,limit=1] Pos[0] double 0.1 run scoreboard players get note_lock_x_val tool_opt
execute if score #fx_axis editor matches 1 run execute store result entity @e[tag=editor_axis_fx,limit=1] Pos[1] double 0.1 run scoreboard players get note_lock_y_val tool_opt
execute if score #fx_axis editor matches 2 run execute store result entity @e[tag=editor_axis_fx,limit=1] Pos[2] double 0.1 run scoreboard players get note_lock_z_val tool_opt
execute if score #fx_axis editor matches 0 run execute at @e[tag=editor_axis_fx,limit=1] run particle minecraft:dust{color:[1.0,0.25,0.25],scale:1.0} ~ ~ ~ 0 1.6 1.6 0.05 200
execute if score #fx_axis editor matches 1 run execute at @e[tag=editor_axis_fx,limit=1] run particle minecraft:dust{color:[0.3,1.0,0.3],scale:1.0} ~ ~ ~ 1.6 0 1.6 0.05 200
execute if score #fx_axis editor matches 2 run execute at @e[tag=editor_axis_fx,limit=1] run particle minecraft:dust{color:[0.4,0.8,1.0],scale:1.0} ~ ~ ~ 1.6 1.6 0 0.05 200
kill @e[tag=editor_axis_fx]
