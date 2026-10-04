kill @e[tag=title]
summon minecraft:text_display -1.375 0.5625 0.5 {\
    alignment: "center", background: 0, default_background: 0b, line_width: 200, see_through: 1b, shadow: 0b, \
    text: {color: "dark_green", text: "攻攻攻"}, text_opacity: 128, \
    transformation: {left_rotation: [0.0f, 1.0f, 0.0f, 0.0f], right_rotation: [0.0f, 0.0f, 0.0f, 1.0f], scale: [8.0f, 8.0f, 8.0f], translation: [0.0f, 0.0f, 0.0f]},\
    Tags:["title"]\
    }
schedule function rhythm_axe:maps/goodworld/title1408_2 2t
