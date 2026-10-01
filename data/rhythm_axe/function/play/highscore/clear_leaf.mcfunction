#arg:i,mapid
# 第 i 个玩家：从名单取出 key → 交给删除叶子（宏参数必须在调用时已存在，故分两层）
$data modify storage rhythm_axe:prop key set from storage rhythm_axe:scores_index $(mapid)[$(i)]
function rhythm_axe:play/highscore/clear_del with storage rhythm_axe:prop
