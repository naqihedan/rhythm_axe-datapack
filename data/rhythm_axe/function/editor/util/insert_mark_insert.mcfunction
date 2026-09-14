# [已废弃 2026-09-14 D1b] 旧版线性插入点查找的子函数；insert_find 已改为指数+二分，不再调用
#arg:index
# 插入点 = 当前索引：记录 insert_index 并写 insert_mode 标记
$data modify storage rhythm_axe:prop insert_index set value $(index)
data modify storage rhythm_axe:prop insert_mode set value "insert"
