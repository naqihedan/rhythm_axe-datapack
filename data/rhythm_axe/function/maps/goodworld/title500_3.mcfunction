# DJ（title500 指令顺序第 3 个）
summon minecraft:text_display -1.75 2.0625 0.5 {\
    alignment: "center", background: 0, default_background: 0b, line_width: 200, see_through: 0b, shadow: 0b, \
    text: "DJ", text_opacity: 255, \
    transformation: {left_rotation: [0.70710677f, -0.70710677f, 0.0f, 0.0f], right_rotation: [0.0f, 0.0f, 0.0f, 1.0f], scale: [0.0f, 0.0f, 0.0f], translation: [0.0f, 0.0f, 0.0f]},\
    Tags: ["title","title500_3"]\
    }
# 3 刻内从缩放 0 放大到目标
execute as @e[tag=title500_3] run data merge entity @s \
    {transformation:{scale:[1.9999996f, 1.4999995f, 2.0000002f]}, interpolation_duration: 3, start_interpolation: 0}
