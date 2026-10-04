#arg:x
# 激光2：召唤一束（x 由 laser2_fire 随机给出）。
# ※ 保留 Tags:["laser2"] 供 laser2_main 驱动（不要用 laser —— 那是激光1 的 tag，会被 laser_main 管）。
$summon minecraft:text_display $(x) 5.5 64.5 {\
    alignment: "right", background: -2130706584, default_background: 0b, line_width: 200, see_through: 1b, shadow: 0b, \
    text: "乂乂乂乂乂乂乂乂乂乂乂乂乂乂乂乂乂乂乂乂乂乂乂乂乂乂乂乂乂乂乂乂乂乂乂乂乂乂乂乂\n乂乂乂乂乂乂乂乂乂乂乂乂乂乂乂乂乂乂乂乂乂乂乂乂乂乂乂乂乂乂乂乂乂乂乂乂乂乂乂乂\n乂乂乂乂乂乂乂乂乂乂乂乂乂乂乂乂乂乂乂乂乂乂乂乂乂乂乂乂乂乂乂乂乂乂乂乂乂乂乂乂\n乂乂乂乂乂乂乂乂乂乂乂乂乂乂乂乂乂乂乂乂乂乂乂乂乂乂乂乂乂乂乂乂乂乂乂乂乂乂乂乂",\
    text_opacity: -1b, \
    transformation: {left_rotation: [0.5f, 0.5f, -0.5f, 0.5f], right_rotation: [0.0f, 0.0f, 0.0f, 1.0f], scale: [3.0f, 3.0f, 3.0f], translation: [0.0f, 0.0f, 0.0f]},\
    Tags:["laser2"]\
    }
