#arg:pv_len
# 用宏把「预览时长（刻）」注入 schedule 的时间参数。
#   ⚠️ schedule 命令本身**没有 with 参数**（26.2 实测报「错误的命令参数」），
#   但它的**时间参数可以宏注入**（`$(pv_len)t`）⇒ 不需要「每 5 刻自检一次」那种轮询，
#   到点由 preview/stop 自己停，误差 0 刻。
#   replace = 覆盖**同一函数**的待执行条目 ⇒ 换歌/重播时旧条目自动作废，不会提前把新预览停掉。
#   ⚠️ 时间非法（负数/非数字）会让整行报错 ⇒ 调用方 preview/start 已保证 pv_len ≥ 1。
$schedule function rhythm_axe:map_list/preview/stop $(pv_len)t replace
