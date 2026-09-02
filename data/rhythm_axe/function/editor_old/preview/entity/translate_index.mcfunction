# ========== index_line 缓动动画（自启动版本）==========
# 复用 translate_prep 计算绝对目标，然后启动独立动画
function rhythm_axe:editor/preview/entity/translate_prep

# 启动位移动画（三次方缓出，10 tick）
scoreboard players set #ANIM_DURATION display_calc 10
scoreboard players set #ANIM_EASING display_calc 2
scoreboard players set #ANIM_POWER display_calc 3
scoreboard players set #ANIM_APPLY_POSITION display_calc 0
tag @e[type=block_display,tag=timeline_preview,limit=1] add anim_task
function rhythm_axe:utilization/display_animation/display_animation