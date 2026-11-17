# ========== mobilys 手电筒扫光 · 续段（谱面第 1776 刻触发）==========
# 文件名数字 = 谱面里的事件触发刻数；整段 1776 → 2172 刻（396 刻 = 19.8s）。
# 与第一段（mobilys_flashlight1392，1392 → 1775）共用同一套 marker / 计分板 / end。
#
# 墙（x=-6 / x=2，z=-5..31，y=0..2 三层的条纹完全一致）是「青 3 格 + 白 3 格」，6 段青：
#   -1..1 | 5..7 | 11..13 | 17..19 | 23..25 | 29..31（白段不参与，永远不会被改）
#
# 一轮 4 步（每 12 刻一步），走完 = 整面墙一圈（-1 → 35 → 回卷回 -1）：
#   第 1 步 +6   → 刷第 1 段
#   第 2 步 +6   → 刷第 2 段
#   第 3 步 +6   → 刷第 3 段
#   第 4 步 +18  → 一次刷第 4、5、6 段，回卷 36 格回起点
# 每步先把上一格的黄整墙刷回青、再刷当前格 ⇒ 看起来是黄色光带每 12 刻往前跳一次。
#
# 时间轴：1776 刻起步（第 1 步），每 12 刻一步，共 32 步 = 8 整轮：
#         第 32 步在 2148 刻（第 8 轮第 4 步刷完 4-6 段并落回起点），2172 刻收场。
#         ★ 第 9 轮那不成轮的一步不跑 —— 否则结尾会把开头第 1 段刷黄。
# ★ 可重复执行（谱面规范第 4 条：进度条拖动会在持续期内重复触发）：
#   init 清全部调度（含第一段可能没跑完的链、以及已排队的 end）/ 清 marker / 还原墙面 /
#   #step、#steps 归零 ⇒ 重复触发 = 从第 1 步重跑，不会双链叠加。

# init（同时自愈上一轮被打断的残留）
scoreboard objectives add mobilys_flashlight dummy
scoreboard players set #step mobilys_flashlight 0
scoreboard players set #steps mobilys_flashlight 0
kill @e[type=minecraft:marker,tag=mobilys_flashlight]
schedule clear rhythm_axe:maps/mobilys/mobilys_flashlight_fire
schedule clear rhythm_axe:maps/mobilys/mobilys_flashlight_maincycle
schedule clear rhythm_axe:maps/mobilys/mobilys_flashlight1776_step
schedule clear rhythm_axe:maps/mobilys/mobilys_flashlight_end
fill -6 2 31 2 0 -5 cyan_stained_glass_pane replace yellow_stained_glass_pane

# 两块侧墙各一支 marker（复用第一段的发射阵列），起步位置 z=-1
function rhythm_axe:maps/mobilys/mobilys_flashlight_fire

# main：每 12 刻一步
function rhythm_axe:maps/mobilys/mobilys_flashlight1776_step
