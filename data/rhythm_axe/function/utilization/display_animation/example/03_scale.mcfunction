# ========== 示例 3：缩放动画 ==========
# 从 1.0 倍放大到 3.0 倍（delta=+200），缓入，四次方，持续 2 tick

scoreboard players set #ANIM_DURATION display_calc 2
scoreboard players set #ANIM_EASING display_calc 1
scoreboard players set #ANIM_POWER display_calc 4

scoreboard players set #ANIM_DELTA_SX display_calc 200
scoreboard players set #ANIM_DELTA_SY display_calc 200
scoreboard players set #ANIM_DELTA_SZ display_calc 200

tag @e[tag=anim_demo] add anim_task
function rhythm_axe:utilization/display_animation/display_animation

tellraw @a ["",{"text":"[动画示例] ","color":"gold"},{"text":"执行缩放动画","color":"green"}]

