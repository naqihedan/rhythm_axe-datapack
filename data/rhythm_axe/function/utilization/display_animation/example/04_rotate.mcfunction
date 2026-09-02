# ========== 示例 4：旋转动画==========

scoreboard players set #ANIM_DURATION display_calc 20
scoreboard players set #ANIM_EASING display_calc 3
scoreboard players set #ANIM_POWER display_calc 5

scoreboard players set #ANIM_DELTA_RX display_calc 45
scoreboard players set #ANIM_DELTA_RZ display_calc 5

tag @e[tag=anim_demo] add anim_task
function rhythm_axe:utilization/display_animation/display_animation

tellraw @a ["",{"text":"[动画示例] ","color":"gold"},{"text":"执行旋转动画","color":"green"}]
