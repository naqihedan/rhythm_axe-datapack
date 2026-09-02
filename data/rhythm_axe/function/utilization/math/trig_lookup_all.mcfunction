# ========== 三角函数查表（宏函数 - 三轴合并）==========
# 宏参数：{angle_rx:N, angle_ry:N, angle_rz:N} 其中 N 为表索引（0~3599）
#arg: angle_rx, angle_ry, angle_rz
# 一次宏调用同时查找 rx/ry/rz 三个轴的 sin/cos 值。
# 写入独立 storage（避免修改宏自身的上下文 storage）
$data modify storage display_animation:trig_result sin_rx set from storage display_animation:trig_table trig[$(angle_rx)].sin
$data modify storage display_animation:trig_result cos_rx set from storage display_animation:trig_table trig[$(angle_rx)].cos
$data modify storage display_animation:trig_result sin_ry set from storage display_animation:trig_table trig[$(angle_ry)].sin
$data modify storage display_animation:trig_result cos_ry set from storage display_animation:trig_table trig[$(angle_ry)].cos
$data modify storage display_animation:trig_result sin_rz set from storage display_animation:trig_table trig[$(angle_rz)].sin
$data modify storage display_animation:trig_result cos_rz set from storage display_animation:trig_table trig[$(angle_rz)].cos
