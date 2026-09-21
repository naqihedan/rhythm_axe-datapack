#arg: i, new_id
# 索引查重叶子（宏，单步不递归）：index[$(i)] == new_id ⇒ #idx_stop=1
# （字符串比较走"复制到 prop + 复合标签匹配"——本库判断 storage 字段值的既定写法）
$data modify storage rhythm_axe:prop probe set from storage rhythm_axe:maps index[$(i)]
$execute if data storage rhythm_axe:prop {probe:"$(new_id)"} run scoreboard players set #idx_stop editor 1
