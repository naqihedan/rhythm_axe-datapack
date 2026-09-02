#arg:label
# 显示三位小数值（去掉 d/f 后缀）：输入 score #v（值×1000），输出 "label + 数值"
# ★ 修负数值颠倒/补数：计分板 /= 是向下取整、%= 是 floorMod（余数恒非负），用 #v 直接拆会导致负数整数/小数位错位。
#   改为「取绝对值拆分 + 独立符号标记」，符号由 #vi 负号承载（|值|≥1），负零用 #nz 加前导负号。
scoreboard players set #vneg editor 0
execute if score #v editor matches ..-1 run scoreboard players set #vneg editor 1
scoreboard players operation #vi editor = #v editor
execute if score #vi editor matches ..-1 run scoreboard players operation #vi editor *= -1 const
scoreboard players operation #vf editor = #vi editor
scoreboard players operation #vi editor /= 1000 const
scoreboard players operation #vf editor %= 1000 const
scoreboard players set #nz editor 0
execute if score #vneg editor matches 1 if score #vi editor matches 0 run scoreboard players set #nz editor 1
execute if score #vneg editor matches 1 run scoreboard players operation #vi editor *= -1 const
# 始终补零三位显示（整数也显示 .000）；#vf==0 走 0..9 分支
$execute if score #nz editor matches 1 if score #vf editor matches 0..9 run tellraw @s [{"text":"$(label)","color":"gray"},{"text":"-","color":"white"},{"score":{"name":"#vi","objective":"editor"},"color":"gold"},{"text":".00","color":"gold"},{"score":{"name":"#vf","objective":"editor"},"color":"gold"}]
$execute if score #nz editor matches 1 if score #vf editor matches 10..99 run tellraw @s [{"text":"$(label)","color":"gray"},{"text":"-","color":"white"},{"score":{"name":"#vi","objective":"editor"},"color":"gold"},{"text":".0","color":"gold"},{"score":{"name":"#vf","objective":"editor"},"color":"gold"}]
$execute if score #nz editor matches 1 if score #vf editor matches 100..999 run tellraw @s [{"text":"$(label)","color":"gray"},{"text":"-","color":"white"},{"score":{"name":"#vi","objective":"editor"},"color":"gold"},{"text":".","color":"gold"},{"score":{"name":"#vf","objective":"editor"},"color":"gold"}]
$execute if score #nz editor matches 0 if score #vf editor matches 0..9 run tellraw @s [{"text":"$(label)","color":"gray"},{"score":{"name":"#vi","objective":"editor"},"color":"gold"},{"text":".00","color":"gold"},{"score":{"name":"#vf","objective":"editor"},"color":"gold"}]
$execute if score #nz editor matches 0 if score #vf editor matches 10..99 run tellraw @s [{"text":"$(label)","color":"gray"},{"score":{"name":"#vi","objective":"editor"},"color":"gold"},{"text":".0","color":"gold"},{"score":{"name":"#vf","objective":"editor"},"color":"gold"}]
$execute if score #nz editor matches 0 if score #vf editor matches 100..999 run tellraw @s [{"text":"$(label)","color":"gray"},{"score":{"name":"#vi","objective":"editor"},"color":"gold"},{"text":".","color":"gold"},{"score":{"name":"#vf","objective":"editor"},"color":"gold"}]
