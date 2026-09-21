#arg: i, mapid
# 索引自检叶子（宏，单步不递归）：正式存储存在 ⇒ 保留（append 进新索引）
$execute if data storage rhythm_axe:maps.$(mapid) id run data modify storage rhythm_axe:prop idx_new append value "$(mapid)"
