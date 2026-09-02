# 混凝土段②：平移（客户端插值，仅线性 easing=1 power=1，2026-08-10 单阶段重构 / 2026-08-14 加 start=0）
# @s = 混凝土展示实体（tick 检测到段①插值进行中且线性时调用）
# 起点 = 客户端当前渲染位置（触发时刻段①插值已走完 = 段①终点，稳定）
# 段②终点：translation.z = z2 = -dist×m/(2lt) + size/2；scale.z = len1 = dist×m/lt（恒定）
# 插值时长 = lt - m（平移段）
# ★ 单阶段（2026-08-14）：本 tick 一次性下发 插值时长 + start=0 + 终点（同刻多次变更=单个变更）
#   ★ 必须重设 start=0：不重置的话段①时钟继续走，进度按新时长(lt-m)重算 → 段②起步即前跳 ~(m-2)/(lt-m)
#     （用户实测"短 hold 运动不连贯"根因之一）→ 重置后从当前渲染位置平滑开始，无前跳
# ★ 显式清 anim_status：段②不再由 display_animation 逐帧驱动

# 段②插值时长 = lt - m（平移段；<=0 保护）
scoreboard players operation #ANIM_DURATION display_calc = @s note_c_lt
scoreboard players operation #ANIM_DURATION display_calc -= @s note_c_m
execute if score #ANIM_DURATION display_calc matches ..0 run scoreboard players set #ANIM_DURATION display_calc 1
execute store result entity @s interpolation_duration int 1 run scoreboard players get #ANIM_DURATION display_calc
# ★ 重置插值时钟（与上方时长、下方终点同刻下发）
data modify entity @s start_interpolation set value 0
# 停止 display_animation 逐帧驱动（防残留 step 覆盖插值）
scoreboard players set @s anim_status 0
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
# 单条 merge（transformation 变 → 客户端从当前渲染位置插值到段②终点）
data modify entity @s {} merge from storage rhythm_axe:motion m
# 记录插值起点 tick（交互实体段②进度用）
execute store result score @s note_c_seg2_s run scoreboard players get #ct display_calc
# 清理 + 记录当前段
execute if data storage rhythm_axe:motion m run data remove storage rhythm_axe:motion m
scoreboard players set @s note_c_seg 2