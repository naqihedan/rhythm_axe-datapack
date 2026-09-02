# 混凝土段②终点 merge（@s = 混凝土展示实体；tag=note_concrete_seg2_pending + active=1 时调用）
# 段②终点：translation.z = z2 = -dist×m/(2lt) + size/2；scale.z = len1 = dist×m/lt（恒定）
# ★ 只 merge 一次（随后移除 pending tag）；客户端在 interpolation_duration 内从段①终点插值到段②终点
# ★ 记录插值起点 tick（note_c_seg2_s = 当前 #ct）→ concrete/tick 用它算交互实体段②进度
#   （段② anim_status=0，交互不能再复刻 anim_timer）

# 段②终点 z2 = -dist×m/(2lt) + size/2（×100）
scoreboard players operation #c2z display_calc = @s note_c_m
scoreboard players operation #c2z display_calc *= @s note_c_dist
scoreboard players operation #c2z display_calc /= @s note_c_lt
scoreboard players operation #c2z display_calc /= 2 const
scoreboard players operation #c2z display_calc *= -1 const
scoreboard players operation #c_tmp display_calc = @s note_c_size
scoreboard players operation #c_tmp display_calc /= 2 const
scoreboard players operation #c2z display_calc += #c_tmp display_calc
# 长度 len1 = dist×m/lt（段①终点值，恒定）
scoreboard players operation #clen display_calc = @s note_c_dist
scoreboard players operation #clen display_calc *= @s note_c_m
scoreboard players operation #clen display_calc /= @s note_c_lt
# 组装终点 transformation（translation 只动 z；scale 保持 size_x/size_y、z=len1）
data modify storage rhythm_axe:motion m set value {}
data modify storage rhythm_axe:motion m.transformation set value {translation:[0.0,0.0,0.0]}
execute store result storage rhythm_axe:motion m.transformation.translation[2] float 0.01 run scoreboard players get #c2z display_calc
data modify storage rhythm_axe:motion m.transformation.scale set value [0.0,0.0,0.0]
execute store result storage rhythm_axe:motion m.transformation.scale[0] float 0.01 run data get entity @s transformation.scale[0] 100
execute store result storage rhythm_axe:motion m.transformation.scale[1] float 0.01 run data get entity @s transformation.scale[1] 100
execute store result storage rhythm_axe:motion m.transformation.scale[2] float 0.01 run scoreboard players get #clen display_calc
# 单条 merge（不带插值参数 → 插值从上次更新继续，时长 = interpolation_duration）
data modify entity @s {} merge from storage rhythm_axe:motion m
# 记录插值起点 tick（交互实体段②进度用，覆盖为 merge tick 更准）
execute store result score @s note_c_seg2_s run scoreboard players get #ct display_calc
# 清理 + 移除 pending 标记
execute if data storage rhythm_axe:motion m run data remove storage rhythm_axe:motion m
tag @s remove note_concrete_seg2_pending