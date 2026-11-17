# main cycle

scoreboard players add @e[type=minecraft:marker,tag=mobilys_flashlight] mobilys_flashlight 1
scoreboard players add #time mobilys_flashlight 1


# marker驱动
execute as @e[type=minecraft:marker,tag=mobilys_flashlight,scores={mobilys_flashlight=..6}] at @s run \
    fill ~ ~ ~ ~ ~2 ~2 minecraft:yellow_stained_glass_pane replace cyan_stained_glass_pane
execute as @e[type=minecraft:marker,tag=mobilys_flashlight,scores={mobilys_flashlight=..6}] at @s run \
    tp @s ~ ~ ~6

# 第 6 刻是黄→青转折刻：先按「≤6」铺完最后一段黄并前进，再回卷 36 格回起点开始刷青
execute as @e[type=minecraft:marker,tag=mobilys_flashlight,scores={mobilys_flashlight=6}] at @s run \
    tp @s ~ ~ ~-36
execute as @e[type=minecraft:marker,tag=mobilys_flashlight,scores={mobilys_flashlight=6..}] at @s run \
    fill ~ ~ ~ ~ ~2 ~2 minecraft:cyan_stained_glass_pane replace yellow_stained_glass_pane
execute as @e[type=minecraft:marker,tag=mobilys_flashlight,scores={mobilys_flashlight=6..}] at @s run \
    tp @s ~ ~ ~6

# 第 12 刻位置已到 z=35（场景只到 z=31），本刻的 fill 是空转，只为走完 12 刻生命周期再自杀
kill @e[type=minecraft:marker,tag=mobilys_flashlight,scores={mobilys_flashlight=12..}]

# 循环控制（time = 谱面刻 − 1391；time=373 ⇒ 谱面第 1764 刻收场）
execute unless score #time mobilys_flashlight matches 373 run \
    schedule function rhythm_axe:maps/mobilys/mobilys_flashlight_maincycle 1t
execute if score #time mobilys_flashlight matches 373 run \
    function rhythm_axe:maps/mobilys/mobilys_flashlight_end