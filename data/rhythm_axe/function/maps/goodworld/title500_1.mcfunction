# 背景条（title500 指令顺序第 1 个）
summon minecraft:text_display -1.5 0.75 0.5 {\
    alignment: "center", background: -2147483648, default_background: 0b, line_width: 65, see_through: 0b, shadow: 0b, \
    text: "                                                                                       ", text_opacity: 255, \
    transformation: {left_rotation: [0.0f, 1.0f, 0.0f, 0.0f], right_rotation: [0.0f, 0.0f, 0.0f, 1.0f], scale: [0.0f, 0.0f, 0.0f], translation: [0.0f, 0.0f, 0.0f]},\
    Tags: ["background","title500_1"]\
    }
# 3 刻内从缩放 0 放大到目标
execute as @e[tag=title500_1] run data merge entity @s \
    {transformation:{scale:[0.99999976f, 1.0f, 0.99999976f]}, interpolation_duration: 3, start_interpolation: 0}
