# 在1184开始的黑色玻璃在判定位置生成警告展示实体
function rhythm_axe:maps/goodworld/blackglass_warning_remove

summon minecraft:text_display -0.5 1.0 0.5 {\
    alignment: "center", background: 1073741824, default_background: 0b, line_width: 200, see_through: 1b, shadow: 0b, \
    text: {color: "red", text: "⚠"}, text_opacity: 192, \
    transformation: {left_rotation: [0.0f, 1.0f, 0.0f, 0.0f], right_rotation: [0.0f, 0.0f, 0.0f, 1.0f], scale: [3.625f, 3.625f, 3.625f], translation: [0.0f, 0.0f, 0.0f]},\
    Tags:["blackglass_warning"]\
    }

summon minecraft:text_display 0.5 1.0 0.5 {\
    alignment: "center", background: 1073741824, default_background: 0b, line_width: 200, see_through: 1b, shadow: 0b, \
    text: {color: "red", text: "⚠"}, text_opacity: 192, \
    transformation: {left_rotation: [0.0f, 1.0f, 0.0f, 0.0f], right_rotation: [0.0f, 0.0f, 0.0f, 1.0f], scale: [3.625f, 3.625f, 3.625f], translation: [0.0f, 0.0f, 0.0f]},\
    Tags:["blackglass_warning"]\
    }

summon minecraft:text_display 1.5 1.0 0.5 {\
    alignment: "center", background: 1073741824, default_background: 0b, line_width: 200, see_through: 1b, shadow: 0b, \
    text: {color: "red", text: "⚠"}, text_opacity: 192, \
    transformation: {left_rotation: [0.0f, 1.0f, 0.0f, 0.0f], right_rotation: [0.0f, 0.0f, 0.0f, 1.0f], scale: [3.625f, 3.625f, 3.625f], translation: [0.0f, 0.0f, 0.0f]},\
    Tags:["blackglass_warning"]\
    }

schedule function rhythm_axe:maps/goodworld/blackglass_warning_hide 2t append
schedule function rhythm_axe:maps/goodworld/blackglass_warning_show 3t append
schedule function rhythm_axe:maps/goodworld/blackglass_warning_hide 4t append
schedule function rhythm_axe:maps/goodworld/blackglass_warning_show 5t append

schedule function rhythm_axe:maps/goodworld/blackglass_warning_remove 16t