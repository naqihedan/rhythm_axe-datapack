# 玻璃段②：穿过后段（接入 display_animation，2026-08-08）
# @s = 玻璃展示实体（tick 检测到 t>=lt 且段①动画完成时调用）
# 起点 = 段①终点（display_animation/start 读当前 NBT = 0，自动衔接）
# 段②终点（t=lt+dur）：translation.z = end = dist×dur/lt（穿过判定位置继续向前）
# 插值时长 = dur
# ★ 镜像缓动：段② easing = 段①反向类型（1↔2，3 不变）
#   → 段①末尾速度 = dist×h'(1)/lt = 段②起始速度 = end×h'(1)/dur（h 为段①缓动）→ 拼接处无折点
#   （glass_move 的镜像 = 时间反转+同类型 = 标准重放+反向类型，数学等价；h'(1) 对缓入=0、对缓出=p）
# ★ dur=0 玻璃：end = dist×0/lt = 0 → target=0 不改变 → 段②不动，玻璃停在判定位置（等价旧 glass_move）

# 清空 display_animation 全局参数（防上一音符残留）
function rhythm_axe:utilization/display_animation/reset_globals
# 段②终点 end = dist×dur/lt（×100）
scoreboard players operation #gend display_calc = @s note_c_dist
scoreboard players operation #gend display_calc *= @s note_glass_dur
scoreboard players operation #gend display_calc /= @s note_c_lt
# 设置 display_animation 参数（段②，duration=dur；dur=0 保护为 1）
scoreboard players operation #ANIM_DURATION display_calc = @s note_glass_dur
execute if score #ANIM_DURATION display_calc matches ..0 run scoreboard players set #ANIM_DURATION display_calc 1
# 镜像缓动：反向类型（1↔2，3 不变）
scoreboard players operation #ANIM_EASING display_calc = @s note_c_easing
execute if score #ANIM_EASING display_calc matches 1 run scoreboard players set #ANIM_EASING display_calc 2
execute if score #ANIM_EASING display_calc matches 2 run scoreboard players set #ANIM_EASING display_calc 1
scoreboard players operation #ANIM_POWER display_calc = @s note_c_power
# 终点：translation 只动 z（x/y 保持 0 → target=0 不改变）；scale 恒 size（target=0 → 不改变）
scoreboard players set #ANIM_TARGET_PX display_calc 0
scoreboard players set #ANIM_TARGET_PY display_calc 0
scoreboard players operation #ANIM_TARGET_PZ display_calc = #gend display_calc
scoreboard players set #ANIM_TARGET_SX display_calc 0
scoreboard players set #ANIM_TARGET_SY display_calc 0
scoreboard players set #ANIM_TARGET_SZ display_calc 0
# 启动动画 + 记录当前段
tag @s add anim_task
function rhythm_axe:utilization/display_animation/display_animation
scoreboard players set @s note_g_seg 2
