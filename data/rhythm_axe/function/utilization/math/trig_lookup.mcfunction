# ========== 三角函数查表（宏函数）==========
# 宏参数：{angle:N} 其中 N 为表索引（0~3599，对应角度 0.0°~359.9°，步长 0.1°）
#arg: angle
# 从 init_trig_table 初始化的 storage 中读取 sin/cos 值。
# 写入独立 storage（避免修改宏自身的上下文 storage）
$data modify storage display_animation:trig_result sin set from storage display_animation:trig_table trig[$(angle)].sin
$data modify storage display_animation:trig_result cos set from storage display_animation:trig_table trig[$(angle)].cos
