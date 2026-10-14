# 生成本刻一个元件：随机区域 A(x 1~7) / B(x -11~-5)，z -2~31，y 固定 0.01
#   2026-10-12：两块各朝中间扩 2 格（中间缺口 10 -> 6 格）
scoreboard players remove #g2384_left g2384_t 1
execute store result score #g2384_r g2384_t run random value 0..1
execute if score #g2384_r g2384_t matches 0 run execute store result score #g2384_x g2384_t run random value 1000..7000
execute if score #g2384_r g2384_t matches 1 run execute store result score #g2384_x g2384_t run random value -11000..-5000
execute store result score #g2384_z g2384_t run random value -2000..31000
execute store result storage rhythm_axe:g2384 x double 0.001 run scoreboard players get #g2384_x g2384_t
execute store result storage rhythm_axe:g2384 z double 0.001 run scoreboard players get #g2384_z g2384_t
function rhythm_axe:maps/goodworld/good2384_1 with storage rhythm_axe:g2384
