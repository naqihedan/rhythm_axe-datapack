# ========== 示例 5：综合动画 + 位置补偿 ==========
# 同时平移 + 旋转 + 缩放，缓出，三次方
# X+3 格 + Y+1 格 + Z 轴旋转 180° + 1.0x→1.5x

scoreboard players set #ANIM_DURATION display_calc 10
scoreboard players set #ANIM_EASING display_calc 2
scoreboard players set #ANIM_POWER display_calc 3

scoreboard players set #ANIM_DELTA_PX display_calc 300
scoreboard players set #ANIM_DELTA_PY display_calc 100

scoreboard players set #ANIM_DELTA_RZ display_calc 180

scoreboard players set #ANIM_TARGET_SX display_calc 50
scoreboard players set #ANIM_TARGET_SY display_calc 50
scoreboard players set #ANIM_TARGET_SZ display_calc 50

scoreboard players set #ANIM_APPLY_POSITION display_calc 1

tag @e[tag=anim_demo] add anim_task
function rhythm_axe:utilization/display_animation/display_animation

tellraw @a ["",{"text":"[动画示例] ","color":"gold"},{"text":"执行组合变换动画","color":"green"}]
