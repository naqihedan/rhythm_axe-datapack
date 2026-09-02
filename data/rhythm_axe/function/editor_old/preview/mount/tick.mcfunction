# ========== 三次方缓出每刻循环 (preview) ==========
# 公式: f(i) = 1-(1-(i+1)/16)³ = (4096-(15-step)³)/4096
# pos = base + D × frac / 4096

scoreboard players add step teleport 1
# 首次运行时记录动画代次
execute if score step teleport matches 1 run scoreboard players operation this_gen teleport = mount_gen teleport
# 代次检查：如果 mount_gen 已变（新动画启动），停止当前动画
execute unless score this_gen teleport = mount_gen teleport run return 0

# n = 15 - step  (因为 step 从 1 开始)
scoreboard players operation #n teleport = 15 const
scoreboard players operation #n teleport -= step teleport

# cube = n × n × n
scoreboard players operation #cube teleport = #n teleport
scoreboard players operation #cube teleport *= #n teleport
scoreboard players operation #cube teleport *= #n teleport

# frac = 4096 - cube
scoreboard players operation #frac teleport = 4096 const
scoreboard players operation #frac teleport -= #cube teleport

# X = base_x + Dx × frac / 4096
scoreboard players operation px teleport = Dx teleport
scoreboard players operation px teleport *= #frac teleport
scoreboard players operation px teleport /= 4096 const
scoreboard players operation px teleport += base_x teleport

# Z = base_z + Dz × frac / 4096
scoreboard players operation pz teleport = Dz teleport
scoreboard players operation pz teleport *= #frac teleport
scoreboard players operation pz teleport /= 4096 const
scoreboard players operation pz teleport += base_z teleport

# Y = base_y + Dy × frac / 4096
scoreboard players operation py teleport = Dy teleport
scoreboard players operation py teleport *= #frac teleport
scoreboard players operation py teleport /= 4096 const
scoreboard players operation py teleport += base_y teleport

# 应用位置到盔甲架
execute as @e[type=armor_stand,tag=timeline_mount,limit=1] store result entity @s Pos[0] double 1 run scoreboard players get px teleport
execute as @e[type=armor_stand,tag=timeline_mount,limit=1] store result entity @s Pos[1] double 1 run scoreboard players get py teleport
execute as @e[type=armor_stand,tag=timeline_mount,limit=1] store result entity @s Pos[2] double 1 run scoreboard players get pz teleport

# 如果还有下一步（step < 16），继续循环
execute if score step teleport < 16 const run schedule function rhythm_axe:editor/preview/mount/tick 1t

# 循环结束 + 是返回模式 → 清理坐骑（预览模式不清理）
execute unless score step teleport < 16 const \
        if entity @e[type=armor_stand,tag=timeline_mount,tag=return_mount,limit=1] run \
        kill @e[type=armor_stand,tag=timeline_mount,tag=return_mount,limit=1]
