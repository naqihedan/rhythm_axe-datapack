#arg:i
# 第 i 名参与者：取出 key/name 后交给宏叶子写回（宏参数必须在调用时已存在，故分两层）
$data modify storage rhythm_axe:prop key set from storage rhythm_axe:runtime hs_players[$(i)].key
$data modify storage rhythm_axe:prop name set from storage rhythm_axe:runtime hs_players[$(i)].name
function rhythm_axe:play/highscore/write_enter with storage rhythm_axe:prop
data remove storage rhythm_axe:prop key
data remove storage rhythm_axe:prop name
