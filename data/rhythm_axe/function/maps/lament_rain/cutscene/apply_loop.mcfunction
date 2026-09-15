# 过场写入递归驱动：prop.lr_list 还有元素就处理第 0 个
# （apply_one 处理完会删掉 [0] 并回调本函数，直到列表空）
execute if data storage rhythm_axe:prop lr_list[0] run function rhythm_axe:maps/lament_rain/cutscene/apply_one
