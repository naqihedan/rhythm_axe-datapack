# YO!（title500 指令顺序第 2 个）
summon minecraft:text_display -1.25 1.8125 0.5 {\
    alignment: "center", background: 1073741824, default_background: 0b, line_width: 200, see_through: 0b, shadow: 0b, \
    text: "YO!", text_opacity: 255, \
    transformation: {left_rotation: [0.0f, 1.0f, 0.0f, 0.0f], right_rotation: [0.0f, 0.0f, 0.0f, 1.0f], scale: [0.0f, 0.0f, 0.0f], translation: [0.0f, 0.0f, 0.0f]},\
    Tags: ["title","title500_2"]\
    }
# 3 刻内从缩放 0 放大到目标
execute as @e[tag=title500_2] run data merge entity @s \
    {transformation:{scale:[3.0f, 2.1875f, 3.0f]}, interpolation_duration: 3, start_interpolation: 0}
