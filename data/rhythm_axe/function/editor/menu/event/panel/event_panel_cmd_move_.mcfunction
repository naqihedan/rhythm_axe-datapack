#arg:mv_i,mv_j
# 交换 editing.temp.commands[mv_i] 与 [mv_j]（调用方已保证两个下标都存在）。
# 只改暂存（editing.temp），与【添加指令】/【删除指令】一样「不写历史」，【确认】时才写回工作副本。
$data modify storage rhythm_axe:prop mv_tmp set from storage rhythm_axe:maps.editor editing.temp.commands[$(mv_i)]
$data modify storage rhythm_axe:maps.editor editing.temp.commands[$(mv_i)] set from storage rhythm_axe:maps.editor editing.temp.commands[$(mv_j)]
$data modify storage rhythm_axe:maps.editor editing.temp.commands[$(mv_j)] set from storage rhythm_axe:prop mv_tmp
data remove storage rhythm_axe:prop mv_tmp
