#arg:key,mapid
# 读出这条成绩的名字/分数 → 存进待删槽位 rhythm_axe:lb.del → 弹出原生确认对话框
# 对话框的【删除】调 del_go、【取消】调 del_cancel（见 dialog/lb_delete.json）
data modify storage rhythm_axe:lb del set value {}
$data modify storage rhythm_axe:lb del.key set value "$(key)"
$data modify storage rhythm_axe:lb del.mapid set value "$(mapid)"
data modify storage rhythm_axe:lb del.name set value "?"
$data modify storage rhythm_axe:lb del.name set from storage rhythm_axe:scores $(key).$(mapid).name
data modify storage rhythm_axe:lb del.score set value 0
$execute store result storage rhythm_axe:lb del.score int 1 run data get storage rhythm_axe:scores $(key).$(mapid).score
dialog show @s rhythm_axe:lb_delete
