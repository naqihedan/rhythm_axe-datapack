# 玻璃每 tick（active_note 调用；替代 glass_move 的逐帧驱动）
# @s = 玻璃展示实体
# 1. 段推进：t 到 lt → 段②（等段①动画完成，anim_status 无才启动）
# 2. 交互实体/判定中心跟随：由 move 统一处理（读 note_cur_tz = display_animation/step 写的当前局部 z）
# 视觉由 display_animation 驱动（段①到位 / 段②穿过后段），这里不再写 translation

# ---- 进度 t = lt - l + 1（玻璃渲染延迟 1 刻，视觉寿命0到位判定位置）----
scoreboard players operation #cl play_state = @s note_life
scoreboard players operation #gt display_calc = @s note_c_lt
scoreboard players operation #gt display_calc -= #cl play_state
scoreboard players operation #gt display_calc += 1 const

# ---- 段推进（段①动画完成后启动段②）----
execute if score @s note_g_seg matches 1 if score #gt display_calc >= @s note_c_lt unless score @s anim_status matches 1 run function rhythm_axe:play/note/glass/seg2
