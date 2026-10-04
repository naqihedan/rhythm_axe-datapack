# 临时测试：缓动副本输出（测完删除）
scoreboard players set #ez_total editor 8
scoreboard players set #ez_power editor 2
scoreboard players set #ez_type editor 1
scoreboard players set #ez_n editor 0
tellraw @s [{"text":"== 类型1 缓入 power2 total8 ==","color":"gold"}]
function rhythm_axe:test/df_ease_run
execute store result score #ez_total editor run scoreboard players get #ez_total editor
scoreboard players set #ez_type editor 2
scoreboard players set #ez_n editor 0
tellraw @s [{"text":"== 类型2 缓出 power2 total8 ==","color":"gold"}]
function rhythm_axe:test/df_ease_run
scoreboard players set #ez_type editor 3
scoreboard players set #ez_n editor 0
tellraw @s [{"text":"== 类型3 缓入缓出 power2 total8 ==","color":"gold"}]
function rhythm_axe:test/df_ease_run
scoreboard players set #ez_type editor 1
scoreboard players set #ez_power editor 1
scoreboard players set #ez_n editor 0
tellraw @s [{"text":"== 类型1 power1 线性 total8 ==","color":"gold"}]
function rhythm_axe:test/df_ease_run
scoreboard players set #ez_type editor 1
scoreboard players set #ez_power editor 5
scoreboard players set #ez_n editor 0
tellraw @s [{"text":"== 类型1 缓入 power5 total8 ==","color":"gold"}]
function rhythm_axe:test/df_ease_run
