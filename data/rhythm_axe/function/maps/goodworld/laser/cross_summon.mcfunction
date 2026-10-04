#arg:x,y,s
# 叉号 = 两个展示实体：两根分别在 x 与 x+0.1875，left_rotation 的 x 分量一负一正（±0.38268346）才交叉成叉。
# ※ 保留 Tags:["cross"] 供 cross_main 驱动（与 laser / laser2 互不干扰）。
$execute positioned $(x) $(y) 0.0 run summon minecraft:text_display ~0.1875 ~ ~ {alignment: "right", background: -2130706584, default_background: 0b, line_width: 200, see_through: 1b, shadow: 0b, text: "乂乂乂", text_opacity: 0b, transformation: {left_rotation: [-0.38268346f, 0.9238795f, 0.0f, 0.0f], right_rotation: [0.0f, 0.0f, 0.0f, 1.0f], scale: [$(s)f, $(s)f, $(s)f], translation: [0.0f, 0.0f, 0.0f]}, Tags:["cross"]}
$execute positioned $(x) $(y) 0.0 run summon minecraft:text_display ~ ~ ~ {alignment: "right", background: -2130706584, default_background: 0b, line_width: 200, see_through: 1b, shadow: 0b, text: "乂乂乂", text_opacity: 0b, transformation: {left_rotation: [0.38268346f, 0.9238795f, 0.0f, 0.0f], right_rotation: [0.0f, 0.0f, 0.0f, 1.0f], scale: [$(s)f, $(s)f, $(s)f], translation: [0.0f, 0.0f, 0.0f]}, Tags:["cross"]}
