# ========== 示例 2：平移动画 ==========
# Y 轴方向移动 2 格，缓出，平方，持续 25 tick

scoreboard players set #ANIM_DURATION display_calc 1
scoreboard players set #ANIM_EASING display_calc 2
scoreboard players set #ANIM_POWER display_calc 2
scoreboard players set #ANIM_APPLY_POSITION display_calc 0

scoreboard players set #ANIM_DELTA_PZ display_calc 200

tag @e[tag=anim_demo] add anim_task
function rhythm_axe:utilization/display_animation/display_animation

tellraw @a ["",{"text":"[动画示例] ","color":"gold"},{"text":"执行平移动画","color":"green"}]
