# title1776 开关：执行一次 → 开启 128 刻连发（每 8 刻一对，共 16 对）
# 每对各自从零播动画、互不影响（推进在 title1776_tick：每实例计时 t1776_t、连发计时 #t1776_wave）
# 单对动画（title / background 各 3 次 data merge）：t=2 旋转第一段 + 平移起步；t=6 旋转第二段；t=10 只平移
#   平移 Y：title 0 → -1.5；background -0.0625 → -1.5625（全程低 0.0625）；t=10 同时撤掉 background 的 z 间距
# 位置/生成参数见 title1776summon
#   ★ background 的 z 刻意比 title 深 0.04：两层只差 0.01 时，倾斜姿态下 Δy 与 Δz 会正好抵消→共面→z-fighting（背景白板盖住字）
#     ★ 该间距只在旋转段有效：t=10（第 8 刻）由 title1776_tick 用 Pos 把 background 的 z 撤回 0.5，之后不再施加
# ⚠️ 计分项 t1776_t 由本文件 add、驱动器跑完 remove（完全不依赖 load.mcfunction）；全部跑完自动停链

# 计分项（本套专用）：上一轮跑完会被驱动器 remove，所以这里 add 平时不会报「已存在」
scoreboard objectives add t1776_t dummy

# 第 1 对（第 0 刻）
function rhythm_axe:maps/goodworld/title1776summon

# 连发计时归零（驱动器每 8 刻会再调一次 title1776summon，共 16 对 ⇒ 连开关这次共 16 对）
scoreboard players set #t1776_wave t1776_t 0

# 驱动器：已在跑就不重复启动（否则会出现两条计时链）
execute unless score #t1776_run t1776_t matches 1 run schedule function rhythm_axe:maps/goodworld/title1776_tick 1t
scoreboard players set #t1776_run t1776_t 1



    







    









    