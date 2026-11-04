#arg:rs_prefix,rs_a,rs_b
# 时间点面板「同步缩放」开关行的宏叶子（每次渲染两列）
#   ★ 用法：先 data modify prop.rs_b1..rs_b4 写入组件 JSON 字符串，再调本函数两次
#     「开/关」由渲染方按 options 分数选好组件，本叶子不做判断（保持 1 条命令）。
#   ★ 为什么走宏注入而不是手写 tellraw：4 个开关 × 2 状态 = 8 种组件，
#     直接展开要 8 条 tellraw，宏注入只需 2 条（与 note_panel 的 mcomp/pcomp 同款做法）。
$tellraw @s [{"text":"$(rs_prefix)","color":"gray"},$(rs_a),{"text":"    "},$(rs_b)]
data remove storage rhythm_axe:prop rs_a
data remove storage rhythm_axe:prop rs_b