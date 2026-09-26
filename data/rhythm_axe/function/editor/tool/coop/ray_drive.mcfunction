# 协作工具射线驱动器（普通函数递归；命中或走满 20 步即停）
# 递归在普通函数里做、单步在 ray_step 里 —— 与仓库「普通驱动器 + 单步」惯例一致（避免宏递归下标错乱）
execute if score #coop_hit editor matches 1 run return 0
execute if score #coop_step editor matches 20.. run return 0
scoreboard players add #coop_step editor 1
execute as @e[tag=coop_probe,limit=1] at @s run function rhythm_axe:editor/tool/coop/ray_step
execute if score #coop_hit editor matches 0 run function rhythm_axe:editor/tool/coop/ray_drive
