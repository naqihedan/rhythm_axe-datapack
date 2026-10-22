#arg:st_time
# 第一趟写入叶子（由 find_same_time_collect_drive 调用）：把 time 写进 same_times 复合（键 = time 字符串）
# ★ 只做写入：$(st_time) 是驱动器读好的**新值**（同一实例内先写后读拿旧值的坑已绕开——见驱动器注释）。
#   st_time = -1（未命中/坏元素）不写入（-1 键无意义且会污染集合）。
$execute if score #st_found editor matches 0.. run data modify storage rhythm_axe:prop same_times.$(st_time) set value 1b