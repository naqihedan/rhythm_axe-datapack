# ========== 缓动传送回玩家原位置 (preview) ==========
# 目标：player_origin 标记位置
# 缓动起点：坐骑当前位置

# 读坐骑当前位置作为缓动起点
execute as @e[type=armor_stand,tag=timeline_mount,limit=1] store result score base_x teleport run data get entity @s Pos[0]
execute as @e[type=armor_stand,tag=timeline_mount,limit=1] store result score base_z teleport run data get entity @s Pos[2]
execute as @e[type=armor_stand,tag=timeline_mount,limit=1] store result score base_y teleport run data get entity @s Pos[1]

# 读返回标记位置作为目标
execute as @e[type=marker,tag=player_origin,limit=1] store result score target_x teleport run data get entity @s Pos[0]
execute as @e[type=marker,tag=player_origin,limit=1] store result score target_z teleport run data get entity @s Pos[2]
execute as @e[type=marker,tag=player_origin,limit=1] store result score target_y teleport run data get entity @s Pos[1]

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

# 标记为返回模式（结束时清理坐骑）
tag @e[type=armor_stand,tag=timeline_mount,limit=1] add return_mount

# 递增动画代次（通知旧的 mount/tick 停止）
scoreboard players add mount_gen teleport 1
execute store result storage rhythm_axe:editor mount_gen int 1 run scoreboard players get mount_gen teleport
# 重置步数，启动三次方缓出循环（每刻1步×16步）
scoreboard players set step teleport 0
schedule function rhythm_axe:editor/preview/mount/tick 1t
