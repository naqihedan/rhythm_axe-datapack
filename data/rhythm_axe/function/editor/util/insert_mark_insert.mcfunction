#arg:index
# 插入点 = 当前索引：记录 insert_index 并写 insert_mode 标记
$data modify storage rhythm_axe:prop insert_index set value $(index)
data modify storage rhythm_axe:prop insert_mode set value "insert"
