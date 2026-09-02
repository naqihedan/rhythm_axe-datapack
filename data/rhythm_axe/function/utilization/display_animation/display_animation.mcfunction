# ========== 启动动画（入口）==========
# 调用方式：
#   scoreboard players set #ANIM_... ...   ← 设全局参数
#   tag @e[选择器] add anim_task            ← 标记要进行动画的实体
#   function rhythm_axe:utilization/display_animation/display_animation  ← 执行
#
#  main 内部对 tag=anim_task 的实体执行 start，结束后清理标签和全局参数。
execute if score debug_output options matches 1.. run function rhythm_axe:utilization/display_animation/utils/debug_output
execute as @e[tag=anim_task] run function rhythm_axe:utilization/display_animation/start
# 立即执行首帧：动画在 main 执行的当刻就开始运动（否则要等下一刻 tick.mcfunction 才动，整体晚 1 刻）
execute as @e[tag=anim_task] run function rhythm_axe:utilization/display_animation/step
tag @e[tag=anim_task] remove anim_task
function rhythm_axe:utilization/display_animation/reset_globals
