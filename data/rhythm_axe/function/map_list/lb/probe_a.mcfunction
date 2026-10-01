#arg:i,mapid
# 探针第一层：从待选列表取出第 i 个玩家 key（宏参数必须在调用时已存在，故分两层）
$data modify storage rhythm_axe:prop key set from storage rhythm_axe:lb keys[$(i)]
function rhythm_axe:map_list/lb/probe_b with storage rhythm_axe:prop
