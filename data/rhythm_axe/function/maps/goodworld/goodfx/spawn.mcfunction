# ③ 随机生成一组并播动画（随机值 = 写死的固定值池里取一个）
#   用法：不传参 = 取池里第 1 组；想指定第几组（1..21）：
#     data merge storage rhythm_axe:gfx_good {pick:7}
#     function rhythm_axe:maps/goodworld/goodfx/spawn
#   不写 pick 就默认 1
#   ★ 单组 16 刻死透后自清场（17 刻），计分项/storage 不留残留
function rhythm_axe:maps/goodworld/goodfx/init
schedule function rhythm_axe:maps/goodworld/goodfx/cleanup 17t
execute store result score #pk gfx run data get storage rhythm_axe:gfx_good pick
execute unless score #pk gfx matches 1..21 run scoreboard players set #pk gfx 1
execute if score #pk gfx matches 1 run function rhythm_axe:maps/goodworld/goodfx/waves/launch_g1
execute if score #pk gfx matches 2 run function rhythm_axe:maps/goodworld/goodfx/waves/launch_g2
execute if score #pk gfx matches 3 run function rhythm_axe:maps/goodworld/goodfx/waves/launch_g3
execute if score #pk gfx matches 4 run function rhythm_axe:maps/goodworld/goodfx/waves/launch_g4
execute if score #pk gfx matches 5 run function rhythm_axe:maps/goodworld/goodfx/waves/launch_g5
execute if score #pk gfx matches 6 run function rhythm_axe:maps/goodworld/goodfx/waves/launch_g6
execute if score #pk gfx matches 7 run function rhythm_axe:maps/goodworld/goodfx/waves/launch_g7
execute if score #pk gfx matches 8 run function rhythm_axe:maps/goodworld/goodfx/waves/launch_g8
execute if score #pk gfx matches 9 run function rhythm_axe:maps/goodworld/goodfx/waves/launch_g9
execute if score #pk gfx matches 10 run function rhythm_axe:maps/goodworld/goodfx/waves/launch_g10
execute if score #pk gfx matches 11 run function rhythm_axe:maps/goodworld/goodfx/waves/launch_g11
execute if score #pk gfx matches 12 run function rhythm_axe:maps/goodworld/goodfx/waves/launch_g12
execute if score #pk gfx matches 13 run function rhythm_axe:maps/goodworld/goodfx/waves/launch_g13
execute if score #pk gfx matches 14 run function rhythm_axe:maps/goodworld/goodfx/waves/launch_g14
execute if score #pk gfx matches 15 run function rhythm_axe:maps/goodworld/goodfx/waves/launch_g15
execute if score #pk gfx matches 16 run function rhythm_axe:maps/goodworld/goodfx/waves/launch_g16
execute if score #pk gfx matches 17 run function rhythm_axe:maps/goodworld/goodfx/waves/launch_g17
execute if score #pk gfx matches 18 run function rhythm_axe:maps/goodworld/goodfx/waves/launch_g18
execute if score #pk gfx matches 19 run function rhythm_axe:maps/goodworld/goodfx/waves/launch_g19
execute if score #pk gfx matches 20 run function rhythm_axe:maps/goodworld/goodfx/waves/launch_g20
execute if score #pk gfx matches 21 run function rhythm_axe:maps/goodworld/goodfx/waves/launch_g21
