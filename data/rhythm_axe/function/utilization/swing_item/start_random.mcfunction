# 随机方向挥砍（@s = 玩家；由判定命中点调用）
# 方向随机选 down/left/up/right（/random value 0..3）
# swing_anim（设置面板行 125「实验性挥砍动画」）=0（默认）：不播自定义 item_model 挥砍动画，
#   退回原版 /swing 让玩家挥一下手臂（纯动画、无音效）；=1：播自定义挥砍动画（实验性）
#   /swing <实体> [mainhand|offhand]，26.2 起可用；函数内执行权限等级 2，不要求玩家是管理员，也不刷屏（函数输出被抑制）
execute unless score swing_anim options matches 1 run swing @s mainhand
execute unless score swing_anim options matches 1 run return 0
execute store result score #swing_dir play_state run random value 0..3
execute if score #swing_dir play_state matches 0 run function rhythm_axe:utilization/swing_item/start {type:"down"}
execute if score #swing_dir play_state matches 1 run function rhythm_axe:utilization/swing_item/start {type:"left"}
execute if score #swing_dir play_state matches 2 run function rhythm_axe:utilization/swing_item/start {type:"up"}
execute if score #swing_dir play_state matches 3 run function rhythm_axe:utilization/swing_item/start {type:"right"}
