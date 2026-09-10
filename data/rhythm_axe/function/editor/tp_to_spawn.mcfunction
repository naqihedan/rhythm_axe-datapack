#arg:spawn_x,spawn_y,spawn_z,spawn_yaw,spawn_pitch
# 传送到谱面初始位置与角度（宏上下文 = rhythm_axe:prop）
# ★ 玩家实体不能 data merge 精确设位置：Pos 受物理/强制对齐影响；且宏内联坐标会把 10.0 展开成 10 丢小数。
#   方案：① 玩家处生成 marker → ② data modify 精确写 Pos/Rotation → ③ tp 玩家到 marker → ④ 清除 marker。
#   小数全程走 NBT data modify（不经过坐标宏展开），故可保留初始位置/朝向精度。
kill @e[type=marker,tag=editor_tp_marker]
execute as @s at @s run summon marker ~ ~ ~ {Tags:["editor_tp_marker"]}
execute as @e[type=marker,tag=editor_tp_marker,limit=1,sort=nearest] run data modify entity @s Pos[0] set from storage rhythm_axe:prop spawn_x
execute as @e[type=marker,tag=editor_tp_marker,limit=1,sort=nearest] run data modify entity @s Pos[1] set from storage rhythm_axe:prop spawn_y
execute as @e[type=marker,tag=editor_tp_marker,limit=1,sort=nearest] run data modify entity @s Pos[2] set from storage rhythm_axe:prop spawn_z
execute as @e[type=marker,tag=editor_tp_marker,limit=1,sort=nearest] run data modify entity @s Rotation[0] set from storage rhythm_axe:prop spawn_yaw
execute as @e[type=marker,tag=editor_tp_marker,limit=1,sort=nearest] run data modify entity @s Rotation[1] set from storage rhythm_axe:prop spawn_pitch
tp @s @e[type=marker,tag=editor_tp_marker,limit=1,sort=nearest]
kill @e[type=marker,tag=editor_tp_marker,limit=1,sort=nearest]
