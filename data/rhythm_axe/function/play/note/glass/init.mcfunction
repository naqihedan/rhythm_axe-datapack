# 玻璃段①：到位（接入 display_animation，2026-08-08）
# @s = 玻璃展示实体（summon 时调用，仅非线性玻璃或 dur=0 玻璃；线性玻璃走客户端插值 motion/init）
# 运动模型（两段 display_animation，替代 glass_move 逐帧驱动）：
#   段① t 0→lt      ：translation.z 从 -dist → 0（到位判定位置），duration=lt
#   段② t lt→lt+dur ：translation.z 从 0 → +end（end=dist×dur/lt，穿过判定位置继续向前），duration=dur
#   进度 t = lt - l + 1（玻璃渲染延迟 1 刻，视觉寿命0到位判定位置）
# ★ 段②缓动 = 段①反向类型（1↔2，3 不变）→ 拼接处速度连续（与 glass_move 镜像缓动数学等价）
# ★ 交互实体/判定中心由 move 统一跟随（display_animation/step 每 tick 写 note_cur_tz）
# 输入（实体计分板）：note_c_lt（note_base_life）、note_c_dist（dist×100）、note_c_easing/power（缓动）、
#   note_glass_dur（duration）
# 起点 = 出生局部状态（summon 已设 translation.z=-dist、x/y=0、scale=size）

# 清空 display_animation 全局参数（防上一音符残留）
function rhythm_axe:utilization/display_animation/reset_globals
# 段①终点 = 0（判定位置）：
#   ★ target=0 在 display_animation 是"不改变"语义（0 不匹配 1.. / ..-1，end 保持 start）→
#     无法表达"目标为 0" → 用 DELTA +dist 表达归零（start=-dist → end = start + DELTA = 0）
scoreboard players operation #ANIM_DELTA_PZ display_calc = @s note_c_dist
# 设置 display_animation 参数（段①，duration=lt）
scoreboard players operation #ANIM_DURATION display_calc = @s note_c_lt
execute if score #ANIM_DURATION display_calc matches ..0 run scoreboard players set #ANIM_DURATION display_calc 1
scoreboard players operation #ANIM_EASING display_calc = @s note_c_easing
scoreboard players operation #ANIM_POWER display_calc = @s note_c_power
# 启动动画 + 记录当前段
tag @s add anim_task
function rhythm_axe:utilization/display_animation/display_animation
scoreboard players set @s note_g_seg 1
