# ④ 一次生成 n 组（n 组错开 1 刻出生、各自固定伪随机值、共用动画节奏）
#   用法：
#     data merge storage rhythm_axe:gfx_good {n:8}
#     function rhythm_axe:maps/goodworld/goodfx/repeat
#   不写 n 默认 1 组；n 上限 21（固定池大小）
#   ★ 最坏 n=21 时最后一组在第 36 刻死透，40 刻统一清场（可重复调用、幂等）
function rhythm_axe:maps/goodworld/goodfx/init
schedule function rhythm_axe:maps/goodworld/goodfx/cleanup 40t
execute store result score #rn gfx run data get storage rhythm_axe:gfx_good n
execute unless score #rn gfx matches 1..21 run scoreboard players set #rn gfx 1
execute if score #rn gfx matches 1 run function rhythm_axe:maps/goodworld/goodfx/waves/repeat_n1
execute if score #rn gfx matches 2 run function rhythm_axe:maps/goodworld/goodfx/waves/repeat_n2
execute if score #rn gfx matches 3 run function rhythm_axe:maps/goodworld/goodfx/waves/repeat_n3
execute if score #rn gfx matches 4 run function rhythm_axe:maps/goodworld/goodfx/waves/repeat_n4
execute if score #rn gfx matches 5 run function rhythm_axe:maps/goodworld/goodfx/waves/repeat_n5
execute if score #rn gfx matches 6 run function rhythm_axe:maps/goodworld/goodfx/waves/repeat_n6
execute if score #rn gfx matches 7 run function rhythm_axe:maps/goodworld/goodfx/waves/repeat_n7
execute if score #rn gfx matches 8 run function rhythm_axe:maps/goodworld/goodfx/waves/repeat_n8
execute if score #rn gfx matches 9 run function rhythm_axe:maps/goodworld/goodfx/waves/repeat_n9
execute if score #rn gfx matches 10 run function rhythm_axe:maps/goodworld/goodfx/waves/repeat_n10
execute if score #rn gfx matches 11 run function rhythm_axe:maps/goodworld/goodfx/waves/repeat_n11
execute if score #rn gfx matches 12 run function rhythm_axe:maps/goodworld/goodfx/waves/repeat_n12
execute if score #rn gfx matches 13 run function rhythm_axe:maps/goodworld/goodfx/waves/repeat_n13
execute if score #rn gfx matches 14 run function rhythm_axe:maps/goodworld/goodfx/waves/repeat_n14
execute if score #rn gfx matches 15 run function rhythm_axe:maps/goodworld/goodfx/waves/repeat_n15
execute if score #rn gfx matches 16 run function rhythm_axe:maps/goodworld/goodfx/waves/repeat_n16
execute if score #rn gfx matches 17 run function rhythm_axe:maps/goodworld/goodfx/waves/repeat_n17
execute if score #rn gfx matches 18 run function rhythm_axe:maps/goodworld/goodfx/waves/repeat_n18
execute if score #rn gfx matches 19 run function rhythm_axe:maps/goodworld/goodfx/waves/repeat_n19
execute if score #rn gfx matches 20 run function rhythm_axe:maps/goodworld/goodfx/waves/repeat_n20
execute if score #rn gfx matches 21 run function rhythm_axe:maps/goodworld/goodfx/waves/repeat_n21
