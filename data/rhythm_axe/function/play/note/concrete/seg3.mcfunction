# 混凝土段③：收缩（接入 display_animation，2026-08-08）
# @s = 混凝土展示实体（tick 检测到 t>=lt 且段②动画完成时调用）
# 起点 = 段②终点（display_animation/start 读当前 NBT，自动衔接）
# 段③终点（t=lt+m）：translation.z = z3 = size/2（判定位置中心）；scale.z = 0（长条缩没）
# 插值时长 = m（收缩段）
# ★ 段③完成 = 视觉到位出窗位置，随后由 glass/concrete 出窗静默清除

# 清空 display_animation 全局参数（防上一音符残留）
function rhythm_axe:utilization/display_animation/reset_globals
# 段③终点 z3 = size/2（判定位置，×100）
scoreboard players operation #c3z display_calc = @s note_c_size
scoreboard players operation #c3z display_calc /= 2 const
# 段③ scale 归零：起点 scale = 满长（段②终点，恒定），需 DELTA = -满长
#   ★ target=0 在 display_animation 是"不改变"语义（0 不匹配 1.. / ..-1，end 保持 start），
#     无法表达"目标为 0" → 用负增量归零（anim_end = start + delta = 满长 - 满长 = 0）
#   ★ 满长按模型：短= dist×m/lt、长= dist（2026-08-09）
execute if score @s note_c_m <= @s note_c_lt run scoreboard players operation #clen display_calc = @s note_c_dist
execute if score @s note_c_m <= @s note_c_lt run scoreboard players operation #clen display_calc *= @s note_c_m
execute if score @s note_c_m <= @s note_c_lt run scoreboard players operation #clen display_calc /= @s note_c_lt
execute if score @s note_c_m > @s note_c_lt run scoreboard players operation #clen display_calc = @s note_c_dist
execute if score @s note_c_m > @s note_c_lt run scoreboard players operation #clen display_calc += @s note_c_size
scoreboard players operation #clen display_calc *= -1 const
# 设置 display_animation 参数（段③，★ 按模型 2026-08-09：短=m、长=lt）
execute if score @s note_c_m <= @s note_c_lt run scoreboard players operation #ANIM_DURATION display_calc = @s note_c_m
execute if score @s note_c_m > @s note_c_lt run scoreboard players operation #ANIM_DURATION display_calc = @s note_c_lt
execute if score #ANIM_DURATION display_calc matches ..0 run scoreboard players set #ANIM_DURATION display_calc 1
scoreboard players operation #ANIM_EASING display_calc = @s note_c_easing
scoreboard players operation #ANIM_POWER display_calc = @s note_c_power
scoreboard players set #ANIM_TARGET_PX display_calc 0
scoreboard players set #ANIM_TARGET_PY display_calc 0
scoreboard players operation #ANIM_TARGET_PZ display_calc = #c3z display_calc
scoreboard players set #ANIM_TARGET_SX display_calc 0
scoreboard players set #ANIM_TARGET_SY display_calc 0
scoreboard players set #ANIM_TARGET_SZ display_calc 0
scoreboard players operation #ANIM_DELTA_SZ display_calc = #clen display_calc
# 启动动画 + 记录当前段
tag @s add anim_task
function rhythm_axe:utilization/display_animation/display_animation
scoreboard players set @s note_c_seg 3
