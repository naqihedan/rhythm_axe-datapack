#arg:type
# 手持挥砍动画：启动（以玩家身份调用；type = down/left/up/right）
# 只改手持物品的 item_model 组件，其余组件（名称/附魔/耐久等）全程保留
# 仅当手持物品带 custom_data {rhythm_axe:1b}（即小木斧）才启用，否则直接返回
execute unless items entity @s weapon.mainhand *[minecraft:custom_data~{rhythm_axe:1}] run return fail
$data modify storage rhythm_axe:prop swing set value {type:"$(type)"}
# 皮肤编号（custom_data.axe_skin，0~6）；data get 失败时 store 写 0 = 木斧
execute store result storage rhythm_axe:prop swing.skin int 1 run data get entity @s weapon.mainhand.components."minecraft:custom_data".axe_skin
# 帧号起点：0 = 不预热，直接播第 0 帧
# 想重新打开预热就把它改成 -3：开头 3 刻会交替写「最后一帧 / 孪生副本」，
#   占住原版「改模型后前 3 刻不生效」的锁定期，代价是整段动画晚 3 刻
scoreboard players set @s swing_frame 0
scoreboard players set @s swing_par 0
# 总帧数：从 storage 读（gen_swing_frames.py 生成到 _frame_counts，值 = 各段实际帧数）
# ★ 这行兵底值必须跟生成出来的帧数一致（目前 4 段都是 12），否则读失败时会多播几帧
#   → 多出来的那几帧的 modifier 根本不存在，写不进去 → 客户端失去下坠 → 物品会被 +COMPENSATION_Y 顶到悬空
scoreboard players set @s swing_max 12
$execute if data storage rhythm_axe:swing_frames $(type) store result score @s swing_max run data get storage rhythm_axe:swing_frames $(type)
tag @s add Swing
