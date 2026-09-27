#arg:type,frame,skin
# 手持挥砍动画：推进一帧（宏；type/frame/skin 来自 storage rhythm_axe:prop swing）
# 只改 item_model 组件，其余组件不动
$item modify entity @s weapon.mainhand rhythm_axe:swing/$(type)_$(frame)_$(skin)
scoreboard players add @s swing_frame 1
