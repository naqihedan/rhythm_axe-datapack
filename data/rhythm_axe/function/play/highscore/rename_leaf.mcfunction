#arg:i,old
# 第 i 个玩家：从旧名单取出 key → 交给搬移叶子（宏参数必须在调用时已存在，故分两层）
$data modify storage rhythm_axe:prop key set from storage rhythm_axe:scores_index $(old)[$(i)]
function rhythm_axe:play/highscore/rename_move with storage rhythm_axe:prop
