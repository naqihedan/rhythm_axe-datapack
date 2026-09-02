# 混凝土段③：收缩（客户端插值，仅线性 easing=1 power=1，★ 2026-08-14 单阶段重构）
# @s = 混凝土展示实体（tick 检测到段③开始且线性时调用）
# 起点 = 段②终点（触发时刻段②插值已走完，客户端当前渲染状态 = 段②终点，稳定）
# 段③终点：translation.z = size/2（判定位置中心）；scale.z = 0（长条缩没）
# ★ 单阶段（2026-08-14）：本 tick 一次性下发 插值时长 + start=0 + 终点（同刻多次变更=单个变更）
#   → 客户端从当前渲染位置（段②终点）平滑插值，时钟从此刻开始，无前跳、无瞬切卡顿。
#   旧三阶段（瞬切→设参→终点）有 2 tick 空窗 + 瞬切跳变，已弃用（seg3_param/seg3_merge 不再被调用）
# 插值时长（按模型）：长 hold（m>lt）= lt、短 hold（m<=lt）= m

# ★ 插值参数与终点同刻下发（先写参数，最后 merge 终点）
execute if score @s note_c_m > @s note_c_lt run execute store result entity @s interpolation_duration int 1 run scoreboard players get @s note_c_lt
execute if score @s note_c_m <= @s note_c_lt run execute store result entity @s interpolation_duration int 1 run scoreboard players get @s note_c_m
data modify entity @s start_interpolation set value 0
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
# 单条 merge（客户端从段②终点插值到段③终点，时长 = interpolation_duration）
data modify entity @s {} merge from storage rhythm_axe:motion m
# 清理
execute if data storage rhythm_axe:motion m run data remove storage rhythm_axe:motion m
# 停止 display_animation 逐帧驱动（防残留 step 覆盖插值）+ 记录当前段
scoreboard players set @s anim_status 0
scoreboard players set @s note_c_seg 3
