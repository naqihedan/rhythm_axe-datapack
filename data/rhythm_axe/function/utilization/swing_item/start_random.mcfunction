# 随机方向挥砍（@s = 玩家；由判定命中点调用）
# 方向随机选 down/left/up/right（/random value 0..3）；设置 swing_anim=0 时关闭
execute unless score swing_anim options matches 1 run return 0
execute store result score #swing_dir play_state run random value 0..3
execute if score #swing_dir play_state matches 0 run function rhythm_axe:utilization/swing_item/start {type:"down"}
execute if score #swing_dir play_state matches 1 run function rhythm_axe:utilization/swing_item/start {type:"left"}
execute if score #swing_dir play_state matches 2 run function rhythm_axe:utilization/swing_item/start {type:"up"}
execute if score #swing_dir play_state matches 3 run function rhythm_axe:utilization/swing_item/start {type:"right"}
