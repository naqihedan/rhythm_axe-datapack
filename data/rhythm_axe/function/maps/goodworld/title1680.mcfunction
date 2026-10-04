kill @e[tag=title]

# 计数器（驱动器每 8 刻 +1，1~12 步）
scoreboard objectives add title1680_time dummy "title1680闪烁"
scoreboard players set #t1680_p title1680_time 0

summon minecraft:text_display -4.5 1.5 0.5 {\
    alignment: "center", background: 0, default_background: 0b, line_width: 200, see_through: 0b, shadow: 0b, \
    text: {bold: 1b, color: "red", italic: 1b, text: "WARNING"}, text_opacity: 128, \
    transformation: {left_rotation: [0.0f, 0.9986295f, -0.05233596f, 0.0f], right_rotation: [0.0f, 0.0f, 0.0f, 1.0f], scale: [3.3192594f, 2.4894443f, 3.319259f], translation: [0.0f, 0.0f, 0.0f]},\
    Tags:["title","title1680","title1680_move"]\
    }

summon minecraft:text_display -1.5 1.5 0.5 {\
    alignment: "center", background: 0, default_background: 0b, line_width: 200, see_through: 0b, shadow: 0b, \
    text: {bold: 1b, color: "red", italic: 1b, text: "WARNING"}, text_opacity: 128, \
    transformation: {left_rotation: [0.0f, 0.9986295f, -0.05233596f, 0.0f], right_rotation: [0.0f, 0.0f, 0.0f, 1.0f], scale: [3.3192594f, 2.4894443f, 3.319259f], translation: [0.0f, 0.0f, 0.0f]},\
    Tags:["title","title1680","title1680_move"]\
    }

summon minecraft:text_display 1.5 1.5 0.5 {\
    alignment: "center", background: 0, default_background: 0b, line_width: 200, see_through: 0b, shadow: 0b, \
    text: {bold: 1b, color: "red", italic: 1b, text: "WARNING"}, text_opacity: 128, \
    transformation: {left_rotation: [0.0f, 0.9986295f, -0.05233596f, 0.0f], right_rotation: [0.0f, 0.0f, 0.0f, 1.0f], scale: [3.3192594f, 2.4894443f, 3.319259f], translation: [0.0f, 0.0f, 0.0f]},\
    Tags:["title","title1680","title1680_move"]\
    }

# 每 8 刻一步：平移 +0.25 格（3/(96/8)，共 12 步）＋同步切换透明度（细节见 title1680_move）
schedule function rhythm_axe:maps/goodworld/title1680_move 8t
# 第 96 刻清掉本次标题（最后一步的 8 刻插值会被提前切掉 ⇒ 视觉落在 2.75 格；要完整落位把这里改成 104t）
schedule function rhythm_axe:maps/goodworld/title1680_clear 96t
