# 生成一对标题展示实体，并把它们的计时归零（title1776 开关与连发都用本函数；调一次 = 一对新实例）
# 位置：background (-3.0 2.5 0.53) / title (-3.0 2.49 0.49)；t1776_new 是瞬时标记，只归零本次新实体
summon minecraft:text_display -3.0 2.5 0.53 {\
    alignment: "left", background: -1,\
    default_background: 0b, line_width: 200, see_through: 0b, shadow: 0b, \
    text: "#地球ヤバイ", text_opacity: 0b,\
    transformation: {\
        left_rotation: [0.0f, 0.9238795f, 0.38268346f, 0.0f], right_rotation: [0.0f, 0.0f, 0.0f, 1.0f], \
        scale: [1.125f, 1.4375f, 1.4375f], translation: [0.0f, -0.0625f, 0.0f]\
        },\
    Tags: ["background","unanimated","t1776","t1776_new"]\
    }

summon minecraft:text_display -3.0 2.49 0.49 {\
    alignment: "left", background: 1073741824,\
    default_background: 0b, line_width: 200, see_through: 0b, shadow: 0b, \
    text: "#地球ヤバイ", text_opacity: 255,\
    transformation: {\
        left_rotation: [0.0f, 0.9238795f, 0.38268346f, 0.0f], right_rotation: [0.0f, 0.0f, 0.0f, 1.0f], \
        scale: [1.0f, 1.0f, 1.0f], translation: [0.0f, 0.0f, 0.0f]\
        },\
    Tags: ["title","unanimated","t1776","t1776_new"]\
    }

# 只归零本次新生成的实体（不会碰到正在跑的其它实例）
scoreboard players set @e[tag=t1776_new] t1776_t 0
tag @e[tag=t1776_new] remove t1776_new
