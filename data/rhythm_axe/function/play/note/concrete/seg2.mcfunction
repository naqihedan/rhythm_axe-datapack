# 混凝土段②：平移（接入 display_animation，2026-08-08）
# @s = 混凝土展示实体（tick 检测到 t>=m 且段①动画完成时调用）
# 起点 = 段①终点（display_animation/start 读当前 NBT，自动衔接）
# 段②终点（t=lt）：translation.z = z2 = -dist×m/(2lt) + size/2；scale.z = len1 = dist×m/lt（恒定）
# 插值时长 = lt - m（平移段）
# ★ scale.z 不变（target=len1 = 起点值 → 无 scale 动画，长条保持长度整体平移）

# 清空 display_animation 全局参数（防上一音符残留）
function rhythm_axe:utilization/display_animation/reset_globals
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
# 设置 display_animation 参数（段②，duration=lt-m）
scoreboard players operation #ANIM_DURATION display_calc = @s note_c_lt
scoreboard players operation #ANIM_DURATION display_calc -= @s note_c_m
execute if score #ANIM_DURATION display_calc matches ..0 run scoreboard players set #ANIM_DURATION display_calc 1
scoreboard players operation #ANIM_EASING display_calc = @s note_c_easing
scoreboard players operation #ANIM_POWER display_calc = @s note_c_power
scoreboard players set #ANIM_TARGET_PX display_calc 0
scoreboard players set #ANIM_TARGET_PY display_calc 0
scoreboard players operation #ANIM_TARGET_PZ display_calc = #c2z display_calc
scoreboard players set #ANIM_TARGET_SX display_calc 0
scoreboard players set #ANIM_TARGET_SY display_calc 0
scoreboard players operation #ANIM_TARGET_SZ display_calc = #clen display_calc
# 启动动画 + 记录当前段
tag @s add anim_task
function rhythm_axe:utilization/display_animation/display_animation
scoreboard players set @s note_c_seg 2
