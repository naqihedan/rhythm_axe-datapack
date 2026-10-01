#arg:unit,half
# 把 #rnd_v editor（整数，如 ×1000 的坐标/角度）**四舍五入**到 $(unit) 的整数倍，结果写回 #rnd_v
#   $(half) = $(unit) ÷ 2：unit=100/half=50 → 保留 1 位小数（输入按 ×1000 读）；unit=1000/half=500 → 保留整数
# ★ 先取绝对值再取整：计分板 /= 是向下取整，直接对负数做「+half 再取整」会整体偏小一个 unit
#   （-12.3456 会变 -12.4）。绝对值非负 ⇒ 结果与 /= 的取整方向无关；.5 一律进位（远离零，同 Math.round）
# ⚠️ 本函数只能做「四舍五入」，**不能当 floor 用**：取绝对值会把 |值| < 1 的负数压成 0（符号丢失）。
#   要 floor：直接 `×1000 读入 → /= 1000 → *= 1000`（计分板 /= 已是向下取整），见 map/ops/map_spawn_snap_center
# 调用：function rhythm_axe:editor/util/round_score {"unit":"100","half":"50"}
scoreboard players operation #rnd_a editor = #rnd_v editor
execute if score #rnd_a editor matches ..-1 run scoreboard players operation #rnd_a editor *= -1 const
$scoreboard players add #rnd_a editor $(half)
$scoreboard players operation #rnd_a editor /= $(unit) const
$scoreboard players operation #rnd_a editor *= $(unit) const
execute if score #rnd_v editor matches ..-1 run scoreboard players operation #rnd_a editor *= -1 const
scoreboard players operation #rnd_v editor = #rnd_a editor
