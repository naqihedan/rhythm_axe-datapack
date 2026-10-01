#arg:key,mapid
# 删掉某玩家在某谱面上的成绩条目（key = UUID 四个 int 拼串）
$data remove storage rhythm_axe:scores $(key).$(mapid)
