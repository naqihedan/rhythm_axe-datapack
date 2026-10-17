# ========== title2800 开关（入口 · 出生）==========
# 出生当刻 = 第 1 刻；逐刻关键帧在 title2800_frames，驱动器 title2800_tick 每刻推一刻
# 时间轴（刻）：
#   1-5    G2     从 y+2 落下
#   5-9    R2     同上
#   9-13   018    同上
#   12-16  CLIMAX 从 y-2 上升
#   16-20  左斜线  从 y+2 落下
#   24-28  右斜线  从 y-2 上升
#   29-32  退场：6 个实体各自回到**出生时的偏移**（y 又变回 ±2，方向与来时相反）
#   32     全部删除
#
# 实体（共 6 个）：G2 / R2 / 018（scale [3, 2.5, 1]）、CLIMAX（[1.5125, 1.2, 1]）、
#   两条斜线（[0.625, 3.75, 1]，带 sparkle_morpher 组件）
# ★★ 斜线的**倾角在 transformation.left_rotation = [0,0,-0.14780942,0.9890159]（绕 Z 轴）**，
#     不是实体 Rotation 字段 —— 2026-10-17 曾把它写成单位四元数，导致斜线变竖线。
#     本套动画只写 scale + translation，唯一会碰 left_rotation 的地方就是这里的出生 NBT。
# ★ 出生时 6 个实体 scale 全为 0（不可见）、translation.y 已放到各自的起始偏移；
#   轮到谁时，frames 在那一刻把 scale 还原成满态（= 显形）并开始移动
# ★ 缓动 = 四次缓入缓出；逐刻一帧 + interpolation_duration:1（客户端补帧）
#   每个实体入场结束时位移=0、**退场（29-32）回到出生时的 ±2 偏移**，然后第 32 刻删除
# ★ interpolation_duration 在出生 NBT 里也写了 1（防止首帧无插值）
# ★ 本文件可重复执行：开头先清掉上一轮的残留实体与计时链
# 【手动试一次】/function rhythm_axe:maps/goodworld/title2800
# 【立刻收掉】  /function rhythm_axe:maps/goodworld/title2800_clear

scoreboard objectives add t2800_t dummy
kill @e[tag=t2800]
schedule clear rhythm_axe:maps/goodworld/title2800_tick

# 出生（第 1 刻）：6 个实体 scale 0 + 各自的起始偏移；斜线保留倾角；CLIMAX 透明度与字母一致
summon minecraft:text_display -0.5916 1.3125 0.4375 {Rotation: [180.0f, 0.0f], alignment: "center", background: 0, default_background: 0b, interpolation_duration: 1, line_width: 200, see_through: 1b, shadow: 1b, text: {color: "red", italic: 1b, text: "G2"}, text_opacity: 128, Tags: ["t2800", "t2800_g2"], transformation: {left_rotation: [0.0f, 0.0f, 0.0f, 1.0f], right_rotation: [0.0f, 0.0f, 0.0f, 1.0f], scale: [0.0f, 0.0f, 0.0f], translation: [0.0f, 2.0f, 0.0f]}}
summon minecraft:text_display -1.3654 1.3125 0.4375 {Rotation: [180.0f, 0.0f], alignment: "center", background: 0, default_background: 0b, interpolation_duration: 1, line_width: 200, see_through: 1b, shadow: 1b, text: {color: "red", italic: 1b, text: "R2"}, text_opacity: 128, Tags: ["t2800", "t2800_r2"], transformation: {left_rotation: [0.0f, 0.0f, 0.0f, 1.0f], right_rotation: [0.0f, 0.0f, 0.0f, 1.0f], scale: [0.0f, 0.0f, 0.0f], translation: [0.0f, 2.0f, 0.0f]}}
summon minecraft:text_display -2.2765 1.3125 0.4375 {Rotation: [180.0f, 0.0f], alignment: "center", background: 0, default_background: 0b, interpolation_duration: 1, line_width: 200, see_through: 1b, shadow: 1b, text: {color: "red", italic: 1b, text: "018"}, text_opacity: 128, Tags: ["t2800", "t2800_018"], transformation: {left_rotation: [0.0f, 0.0f, 0.0f, 1.0f], right_rotation: [0.0f, 0.0f, 0.0f, 1.0f], scale: [0.0f, 0.0f, 0.0f], translation: [0.0f, 2.0f, 0.0f]}}
summon minecraft:text_display -1.5 1.125 0.5 {Rotation: [180.0f, 0.0f], alignment: "center", background: 0, default_background: 0b, interpolation_duration: 1, line_width: 200, see_through: 0b, shadow: 1b, text: {italic: 1b, text: "+ C L I M A X +", color: "red"}, text_opacity: 128, Tags: ["t2800", "t2800_climax"], transformation: {left_rotation: [0.0f, 0.0f, 0.0f, 1.0f], right_rotation: [0.0f, 0.0f, 0.0f, 1.0f], scale: [0.0f, 0.0f, 0.0f], translation: [0.0f, -2.0f, 0.0f]}}
summon minecraft:text_display 0.0625 1.1875 0.4375 {Rotation: [-180.0f, 0.0f], alignment: "center", background: -2130750123, default_background: 0b, interpolation_duration: 1, line_width: 200, see_through: 1b, shadow: 1b, text: "\u4e42", text_opacity: 0, Tags: ["t2800", "t2800_slashL"], transformation: {left_rotation: [0.0f, 0.0f, -0.14780942f, 0.9890159f], right_rotation: [0.0f, 0.0f, 0.0f, 1.0f], scale: [0.0f, 0.0f, 0.0f], translation: [0.0f, 2.0f, 0.0f]}}
summon minecraft:text_display -2.9375 1.1875 0.4375 {Rotation: [-180.0f, 0.0f], alignment: "center", background: -2130750123, default_background: 0b, interpolation_duration: 1, line_width: 200, see_through: 1b, shadow: 1b, text: "\u4e42", text_opacity: 0, Tags: ["t2800", "t2800_slashR"], transformation: {left_rotation: [0.0f, 0.0f, -0.14780942f, 0.9890159f], right_rotation: [0.0f, 0.0f, 0.0f, 1.0f], scale: [0.0f, 0.0f, 0.0f], translation: [0.0f, -2.0f, 0.0f]}}

scoreboard players set #t2800_wave t2800_t 0
function rhythm_axe:maps/goodworld/title2800_frames
schedule function rhythm_axe:maps/goodworld/title2800_tick 1t
