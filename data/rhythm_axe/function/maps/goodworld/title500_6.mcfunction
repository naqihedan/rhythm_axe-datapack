# PARTY（title500 指令顺序第 6 个）
summon minecraft:text_display -1.5 0.625 0.5 {\
    alignment: "center", background: 0, default_background: 0b, line_width: 200, see_through: 0b, shadow: 0b, \
    text: {color: "yellow", text: "PARTY"}, text_opacity: 255, \
    transformation: {left_rotation: [0.0f, 1.0f, 0.0f, 0.0f], right_rotation: [0.0f, 0.0f, 0.0f, 1.0f], scale: [0.0f, 0.0f, 0.0f], translation: [0.0f, 0.0f, 0.0f]},\
    Tags: ["title","title500_6"]\
    }
# 3 刻内从缩放 0 放大到目标
execute as @e[tag=title500_6] run data merge entity @s \
    {transformation:{scale:[3.25f, 3.2500002f, 3.2499995f]}, interpolation_duration: 3, start_interpolation: 0}
