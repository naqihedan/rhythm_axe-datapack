#arg:cursor,list_name,kind,new_time
# 规则：一刻内只能有一个时间点/事件点（各自最多 1 个，时间点与事件点可共存）。
# 检查当前工作副本 history[cursor].<list_name> 是否已存在 time == new_time 的元素；
# 若存在则置 prop.dup=1b（由调用方提示并 return fail）。
# ★ 写法（用户亲授）：execute if data + 数组过滤复合标签 [{time:N}]，判断列表里是否已有该 time 的元素。
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].$(list_name)[{time:$(new_time)}] run data modify storage rhythm_axe:prop dup set value 1b