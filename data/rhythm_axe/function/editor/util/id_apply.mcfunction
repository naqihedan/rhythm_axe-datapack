#arg:cursor,index
# 找到目标音符：记录 found_index（删除/复制等操作统一只记录，不在此处修改）
$data modify storage rhythm_axe:prop found_index set value $(index)
