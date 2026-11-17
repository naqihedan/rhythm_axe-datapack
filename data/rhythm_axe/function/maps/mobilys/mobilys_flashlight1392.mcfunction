# ========== mobilys 手电筒扫光（谱面第 1392 刻触发）==========
# 文件名数字 = 谱面里的事件触发刻数；整段 1392 → 1764 刻（372 刻 = 18.6s）。
# 时间轴（相对本事件的刻）：
#   0        两堵侧墙（x=-6 / x=2）各发 1 个 marker，之后每 48 刻再发一组（共 6 组，稀疏铺垫）
#   336-360  每 12 刻发一组（3 组，与 marker 的 12 刻生命周期首尾相接 ⇒ 连续收尾）
#            最后一发（372t）不跑：它在 1764 刻才发，那时本事件已经收场
#   每个 marker：第 1-6 刻把 3 格青色 pane 刷黄并前进 6 格，第 6 刻回卷 36 格，
#                第 7-11 刻沿原路把黄刷回青色，第 12 刻空转一 tick 后自杀
#   373      end 收场（还原方块 / 清实体 / 清调度 / 删计分板；谱面第 1764 刻）
#            ★ 360t 那一发的 marker 正好在 1763 刻把墙还原完，1764 收场是干净的
# ★ 可重复执行（谱面规范第 4 条：进度条拖动会在持续期内重复触发）：
#   init 清全部调度 / 清 marker / 还原墙面 / #time 归零 ⇒ 重复触发 = 从头重跑一遍，
#   不会出现两条链叠加、双倍速率或残留方块。

# init（同时自愈上一轮被打断的残留）
scoreboard objectives add mobilys_flashlight dummy
scoreboard players set #time mobilys_flashlight 0
kill @e[type=minecraft:marker,tag=mobilys_flashlight]
schedule clear rhythm_axe:maps/mobilys/mobilys_flashlight_fire
schedule clear rhythm_axe:maps/mobilys/mobilys_flashlight_maincycle
schedule clear rhythm_axe:maps/mobilys/mobilys_flashlight1776_step
schedule clear rhythm_axe:maps/mobilys/mobilys_flashlight_end
fill -6 2 31 2 0 -5 cyan_stained_glass_pane replace yellow_stained_glass_pane

# 发射阵列
function rhythm_axe:maps/mobilys/mobilys_flashlight_fire
schedule function rhythm_axe:maps/mobilys/mobilys_flashlight_fire 48t append
schedule function rhythm_axe:maps/mobilys/mobilys_flashlight_fire 96t append
schedule function rhythm_axe:maps/mobilys/mobilys_flashlight_fire 144t append
schedule function rhythm_axe:maps/mobilys/mobilys_flashlight_fire 192t append
schedule function rhythm_axe:maps/mobilys/mobilys_flashlight_fire 240t append
schedule function rhythm_axe:maps/mobilys/mobilys_flashlight_fire 288t append

schedule function rhythm_axe:maps/mobilys/mobilys_flashlight_fire 336t append
schedule function rhythm_axe:maps/mobilys/mobilys_flashlight_fire 348t append
schedule function rhythm_axe:maps/mobilys/mobilys_flashlight_fire 360t append
# main（每刻一链，跑到 time=373 自己收场）
function rhythm_axe:maps/mobilys/mobilys_flashlight_maincycle