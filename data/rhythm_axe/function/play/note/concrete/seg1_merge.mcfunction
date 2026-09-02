# 混凝土段①终点 merge（@s = 混凝土展示实体；tag=note_concrete_seg1_pending + active=1 时调用）
# 段①终点（按模型）：
#   短 hold：z1 = -dist×(2lt-m)/(2lt) + size/2；scale.z = len1 = dist×m/lt
#   长 hold：center = -dist/2 + size/2；scale.z = dist（满长）
# ★ 只 merge 一次（随后移除 pending tag）；客户端在 interpolation_duration 内从出生位置插值到段①终点
# ★ 记录插值起点 tick（note_c_seg1_s = 当前 #ct）→ concrete/tick 算交互实体段①进度用

# 长 hold center = -dist/2（★ 2026-08-26 尾端往回退 size/2 → 中心 = -d/2，不再 +size/2）
execute if score @s note_c_m > @s note_c_lt run scoreboard players operation #c1z display_calc = @s note_c_dist
execute if score @s note_c_m > @s note_c_lt run scoreboard players operation #c1z display_calc *= -1 const
execute if score @s note_c_m > @s note_c_lt run scoreboard players operation #c1z display_calc /= 2 const
# 短 hold z1 = -dist×(2lt-m)/(2lt) - size/2（★ 2026-08-26 尾端往回退：+size/2 → -size/2；必须带 <= 条件，否则覆盖长 hold 的 #c1z）
execute if score @s note_c_m <= @s note_c_lt run scoreboard players operation #c1z display_calc = @s note_c_lt
execute if score @s note_c_m <= @s note_c_lt run scoreboard players operation #c1z display_calc *= 2 const
execute if score @s note_c_m <= @s note_c_lt run scoreboard players operation #c1z display_calc -= @s note_c_m
execute if score @s note_c_m <= @s note_c_lt run scoreboard players operation #c1z display_calc *= @s note_c_dist
execute if score @s note_c_m <= @s note_c_lt run scoreboard players operation #c1z display_calc /= @s note_c_lt
execute if score @s note_c_m <= @s note_c_lt run scoreboard players operation #c1z display_calc /= 2 const
execute if score @s note_c_m <= @s note_c_lt run scoreboard players operation #c1z display_calc *= -1 const
execute if score @s note_c_m <= @s note_c_lt run scoreboard players operation #c_tmp display_calc = @s note_c_size
execute if score @s note_c_m <= @s note_c_lt run scoreboard players operation #c_tmp display_calc /= 2 const
execute if score @s note_c_m <= @s note_c_lt run scoreboard players operation #c1z display_calc -= #c_tmp display_calc
# 长度（★ 2026-08-26 尾端往回退 size/2）：短=dist×m/lt、长=dist+size（头端到位 s/2 需多走 size）
execute if score @s note_c_m <= @s note_c_lt run scoreboard players operation #clen display_calc = @s note_c_dist
execute if score @s note_c_m <= @s note_c_lt run scoreboard players operation #clen display_calc *= @s note_c_m
execute if score @s note_c_m <= @s note_c_lt run scoreboard players operation #clen display_calc /= @s note_c_lt
execute if score @s note_c_m > @s note_c_lt run scoreboard players operation #clen display_calc = @s note_c_dist
execute if score @s note_c_m > @s note_c_lt run scoreboard players operation #clen display_calc += @s note_c_size
# 组装终点 transformation（translation 只动 z；scale 保持 size_x/size_y、z=len1/满长）
data modify storage rhythm_axe:motion m set value {}
data modify storage rhythm_axe:motion m.transformation set value {translation:[0.0,0.0,0.0]}
execute store result storage rhythm_axe:motion m.transformation.translation[2] float 0.01 run scoreboard players get #c1z display_calc
data modify storage rhythm_axe:motion m.transformation.scale set value [0.0,0.0,0.0]
execute store result storage rhythm_axe:motion m.transformation.scale[0] float 0.01 run data get entity @s transformation.scale[0] 100
execute store result storage rhythm_axe:motion m.transformation.scale[1] float 0.01 run data get entity @s transformation.scale[1] 100
execute store result storage rhythm_axe:motion m.transformation.scale[2] float 0.01 run scoreboard players get #clen display_calc
# ★ 2026-08-14：插值参数与终点【同一刻】下发（单次变更；时钟从此刻开始 → 无起步前跳）
execute store result entity @s interpolation_duration int 1 run scoreboard players get @s note_c_seg1_dur
data modify entity @s start_interpolation set value 0
# 单条 merge（参数与终点同刻；客户端从出生位置插值到段①终点）
data modify entity @s {} merge from storage rhythm_axe:motion m
# 记录插值起点 tick（交互实体段①进度用）
execute store result score @s note_c_seg1_s run scoreboard players get #ct display_calc
# 清理 + 移除 pending 标记
execute if data storage rhythm_axe:motion m run data remove storage rhythm_axe:motion m
tag @s remove note_concrete_seg1_pending