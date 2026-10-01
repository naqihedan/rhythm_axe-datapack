# title500_7：标题退出——所有标题展示实体「X 轴缩放」在 4 刻内收缩到 0（Y/Z 保持不变）
# 先写好插值参数（4 刻），再把 X 分量改 0 → 从当前横向尺寸平滑收成一条线
execute as @e[tag=title] run data merge entity @s {interpolation_duration: 4, start_interpolation: 0}
execute as @e[tag=background] run data merge entity @s {interpolation_duration: 4, start_interpolation: 0}
execute as @e[tag=title] run data modify entity @s transformation.scale[0] set value 0.0f
execute as @e[tag=background] run data modify entity @s transformation.scale[0] set value 0.0f
