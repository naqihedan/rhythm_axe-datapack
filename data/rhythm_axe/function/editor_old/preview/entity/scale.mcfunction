# ===== 展示实体缩放动画（自启动版本）=====
# 复用 scale_prep 计算绝对目标，然后启动独立动画
function rhythm_axe:editor/preview/entity/scale_prep

# 启动缩放动画（三次方缓出，16 tick）
scoreboard players set #ANIM_DURATION display_calc 16
scoreboard players set #ANIM_EASING display_calc 2
scoreboard players set #ANIM_POWER display_calc 3
tag @e[type=block_display,tag=timeline_preview,limit=1] add anim_task
function rhythm_axe:utilization/display_animation/display_animation
