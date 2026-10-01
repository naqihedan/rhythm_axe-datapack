#arg:key,old,new
# 把某玩家在旧谱面名下的成绩搬到新谱面名下
$data modify storage rhythm_axe:scores $(key).$(new) set from storage rhythm_axe:scores $(key).$(old)
$data remove storage rhythm_axe:scores $(key).$(old)
