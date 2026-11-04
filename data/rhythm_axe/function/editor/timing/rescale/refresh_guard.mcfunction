# 缩放改过 notes[] 时重建世界视觉（非接管路径专用）。

# 判据：#rs_count（rescale 实际写回的判定时间个数）> 0。

# ★ 接管路径（#rs_own=1）不走本函数 —— 那条路由 rescale/finish_next → refresh_next 负责。

#   本函数只服务「比值=1 / 开关全关」等 rescale 提前返回的情形（此时 #rs_count 为上次残留，需先清）。

execute if score #rs_count editor matches 1.. run function rhythm_axe:editor/refresh

