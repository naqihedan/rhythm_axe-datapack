# 手持挥砍动画：计分板注册（load 时调用；reload 重复执行时已存在的 objective 只告警不中断）
# swing_frame = 当前帧号（预热期是负数 -3..-1，正片从 0 起；播完 >= swing_max 进入定格）
# swing_max   = 总帧数（start 时按 type 从 storage 读）
# swing_par   = 定格交替标志（0 = 写 A、1 = 写 B）★ 忘了注册会导致定格什么也不写 → 下坠松开 → 物品悬空
scoreboard objectives add swing_frame dummy
scoreboard objectives add swing_max dummy
scoreboard objectives add swing_par dummy
# 每段挥砍的实际帧数（由 gen_swing_frames.py 生成到 storage）
function rhythm_axe:utilization/swing_item/_frame_counts
