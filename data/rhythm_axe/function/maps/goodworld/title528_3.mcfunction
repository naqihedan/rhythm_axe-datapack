kill @e[tag=background]
kill @e[tag=title]
kill @e[tag=subtitle]

summon minecraft:text_display -1.5 0.5625 0.5625 {\
    Rotation: [180.0f, 0.0f], \
    alignment: "center", background: 0, default_background: 0b, interpolation_duration: 56, line_width: 200, see_through: 0b, shadow: 0b, \
    text: "神", text_opacity: 192, \
    transformation: {left_rotation: [0.0f, 0.0f, 0.0f, 1.0f], right_rotation: [0.0f, 0.0f, 0.0f, 1.0f], scale: [7.875f, 6.4966993f, 1.0f], translation: [0.0f, 0.0f, 0.0f]},\
    Tags: ["background"]\
    }

# summon minecraft:text_display -1.5 1.3125 0.5 {\
    Rotation: [180.0f, 0.0f],\
    alignment: "center", background: 0, default_background: 0b, line_width: 200, see_through: 0b, shadow: 1b, \
    text: {italic: 1b, text: "GOODWORLD"}, text_opacity: 255, \
    transformation: {left_rotation: [0.0f, 0.0f, 0.0f, 1.0f], right_rotation: [0.0f, 0.0f, 0.0f, 1.0f], scale: [3.0f, 2.5f, 1.0f], translation: [0.0f, 0.0f, 0.0f]},\
    Tags: ["title"]\
    }

# summon minecraft:text_display -1.5 1.125 0.5 {\
    Rotation: [180.0f, 0.0f],\
    alignment: "center", background: 0, default_background: 0b, line_width: 200, see_through: 0b, shadow: 1b, \
    text: {italic: 1b, text: "charter: naqihedan"}, text_opacity: 255, \
    transformation: {left_rotation: [0.0f, 0.0f, 0.0f, 1.0f], right_rotation: [0.0f, 0.0f, 0.0f, 1.0f], scale: [1.5125f, 1.2f, 1.0f], translation: [0.0f, 0.0f, 0.0f]},\
    Tags: ["subtitle"]\
    }

schedule function rhythm_axe:maps/goodworld/title528_4 64t