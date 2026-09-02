# ========== 缓动传送：计算目标并启动缓动 (preview) ==========
# 目标公式: X=起始点X，  Z=max(起始点Z+length/8*5, 10006)  Y= max(起始点Y + length/4 , 16)  偏航-90 俯仰90
# 缓动起点：坐骑当前位置（骑乘中），终点：计算出的目标位置

# 读坐骑当前位置作为缓动起点
execute as @e[type=armor_stand,tag=timeline_mount,limit=1] store result score base_x teleport run data get entity @s Pos[0]
execute as @e[type=armor_stand,tag=timeline_mount,limit=1] store result score base_z teleport run data get entity @s Pos[2]
execute as @e[type=armor_stand,tag=timeline_mount,limit=1] store result score base_y teleport run data get entity @s Pos[1]

# 读起始点（marker）计算目标位置
execute as @e[type=marker,tag=timeline_start,limit=1] store result score start_x teleport run data get entity @s Pos[0]
execute as @e[type=marker,tag=timeline_start,limit=1] store result score start_z teleport run data get entity @s Pos[2]
execute as @e[type=marker,tag=timeline_start,limit=1] store result score start_y teleport run data get entity @s Pos[1]

scoreboard players operation target_x teleport = start_x teleport

scoreboard players operation target_z teleport = length editor
scoreboard players operation target_z teleport /= 8 const
scoreboard players operation target_z teleport *= 5 const
scoreboard players operation target_z teleport += start_z teleport
scoreboard players operation target_z teleport > 10006 const

scoreboard players operation target_y teleport = length editor
scoreboard players operation target_y teleport /= 4 const
scoreboard players operation target_y teleport += start_y teleport
scoreboard players operation target_y teleport > 16 const

# 计算差值 D = target - base
scoreboard players operation Dx teleport = target_x teleport
scoreboard players operation Dx teleport -= base_x teleport
scoreboard players operation Dz teleport = target_z teleport
scoreboard players operation Dz teleport -= base_z teleport
scoreboard players operation Dy teleport = target_y teleport
scoreboard players operation Dy teleport -= base_y teleport

# 存入 Storage 供 mount_tick 读取
execute store result storage rhythm_axe:editor base_x double 1 run scoreboard players get base_x teleport
execute store result storage rhythm_axe:editor base_y double 1 run scoreboard players get base_y teleport
execute store result storage rhythm_axe:editor base_z double 1 run scoreboard players get base_z teleport
execute store result storage rhythm_axe:editor target_x double 1 run scoreboard players get target_x teleport
execute store result storage rhythm_axe:editor target_y double 1 run scoreboard players get target_y teleport
execute store result storage rhythm_axe:editor target_z double 1 run scoreboard players get target_z teleport

# 递增动画代次（通知旧的 mount/tick 停止）
scoreboard players add mount_gen teleport 1
execute store result storage rhythm_axe:editor mount_gen int 1 run scoreboard players get mount_gen teleport
# 重置步数，启动三次方缓出循环（每刻1步×16步）
scoreboard players set step teleport 0
schedule function rhythm_axe:editor/preview/mount/tick 1t
