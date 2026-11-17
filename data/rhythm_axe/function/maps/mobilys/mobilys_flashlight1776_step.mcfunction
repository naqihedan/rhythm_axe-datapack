# 每 12 刻一步：整墙把上一格的黄刷回青 → 在当前格刷黄 → 前进
# 一轮 4 步：+6 / +6 / +6 / +18 = 36 格，正好一整面墙（z=-1 → 35），第 4 步回卷回起点
# 第1-3步各刷 1 段（3 格）；第 4 步一次刷 3 段（18 格，含中间白段但白段不会被 replace 命中）

scoreboard players add #step mobilys_flashlight 1
scoreboard players add #steps mobilys_flashlight 1

# 上一格的黄刷回青（整墙一次刷，幂等；白段不会被 replace 命中）
fill -6 2 31 2 0 -5 cyan_stained_glass_pane replace yellow_stained_glass_pane

# 当前位置刷黄
execute if score #step mobilys_flashlight matches 1..3 as @e[type=minecraft:marker,tag=mobilys_flashlight] at @s run \
    fill ~ ~ ~ ~ ~2 ~2 minecraft:yellow_stained_glass_pane replace cyan_stained_glass_pane
execute if score #step mobilys_flashlight matches 4 as @e[type=minecraft:marker,tag=mobilys_flashlight] at @s run \
    fill ~ ~ ~ ~ ~2 ~17 minecraft:yellow_stained_glass_pane replace cyan_stained_glass_pane

# 前进：第 4 步 +18 后顺带回卷 36 格（净 -18），正好停在起点 z=-1
execute if score #step mobilys_flashlight matches 1..3 as @e[type=minecraft:marker,tag=mobilys_flashlight] at @s run \
    tp @s ~ ~ ~6
execute if score #step mobilys_flashlight matches 4 as @e[type=minecraft:marker,tag=mobilys_flashlight] at @s run \
    tp @s ~ ~ ~-18

# 4 步一轮，回到起点
execute if score #step mobilys_flashlight matches 4.. run scoreboard players set #step mobilys_flashlight 0

# 8 整轮 = 32 步：第 32 步（第 8 轮第 4 步）在 2148 刻刷完第 4-6 段并落回起点，
# 之后不再跑第 9 轮那不成轮的一步（否则会把开头第 1 段刷黄），留 24 刻到 2172 刻收场
execute if score #steps mobilys_flashlight matches ..31 run \
    schedule function rhythm_axe:maps/mobilys/mobilys_flashlight1776_step 12t
execute if score #steps mobilys_flashlight matches 32.. run \
    schedule function rhythm_axe:maps/mobilys/mobilys_flashlight_end 24t
