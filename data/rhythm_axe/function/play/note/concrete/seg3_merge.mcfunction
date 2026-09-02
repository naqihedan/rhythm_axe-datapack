# 混凝土段③终点 merge（@s = 混凝土展示实体；tag=note_concrete_seg3_armed 时调用一次）
# 段③终点：translation.z = size/2（判定位置中心）；scale.z = 0（长条缩没）
#   起点 = 实体当前段②终点（客户端已知；插值参数已在 seg3_client 设好 interpolation_duration/start）
# ★ 只 merge 一次（随后移除 armed tag）——客户端在 interpolation_duration 内从起点插值到终点
# ★ 长短 hold 终点相同，起点由实体当前状态决定，一个函数通用

# 终点 translation.z = size/2（×100）
scoreboard players operation #c3z display_calc = @s note_c_size
scoreboard players operation #c3z display_calc /= 2 const
# 组装终点 transformation
data modify storage rhythm_axe:motion m set value {}
data modify storage rhythm_axe:motion m.transformation set value {translation:[0.0,0.0,0.0]}
execute store result storage rhythm_axe:motion m.transformation.translation[2] float 0.01 run scoreboard players get #c3z display_calc
data modify storage rhythm_axe:motion m.transformation.scale set value [0.0,0.0,0.0]
execute store result storage rhythm_axe:motion m.transformation.scale[0] float 0.01 run data get entity @s transformation.scale[0] 100
execute store result storage rhythm_axe:motion m.transformation.scale[1] float 0.01 run data get entity @s transformation.scale[1] 100
# scale[2] 保持 0（长条缩没）
# 单条 merge（不带插值参数 → 插值从上次更新继续，时长 = interpolation_duration）
data modify entity @s {} merge from storage rhythm_axe:motion m
# 清理 + 移除 pending 标记（只 merge 一次；后续 tick 客户端自动插值）
execute if data storage rhythm_axe:motion m run data remove storage rhythm_axe:motion m
tag @s remove note_concrete_seg3_pending
