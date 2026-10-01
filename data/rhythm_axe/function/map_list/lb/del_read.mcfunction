#arg:key,mapid
# 读出这条成绩的名字/分数 → 存进待删槽位 rhythm_axe:lb.del → 弹出确认对话框
# 对话框的【删除】调 del_go、【取消】调 del_cancel
# ★ 2026-10-01 内联对话框：把 del.name 当 NBT 拼进正文（对话框正文不解析 nbt 组件，
#   旧写法看不到玩家名）；顺带改文案只需 /reload，不必重启世界。
data modify storage rhythm_axe:lb del set value {}
$data modify storage rhythm_axe:lb del.key set value "$(key)"
$data modify storage rhythm_axe:lb del.mapid set value "$(mapid)"
data modify storage rhythm_axe:lb del.name set value "?"
$data modify storage rhythm_axe:lb del.name set from storage rhythm_axe:scores $(key).$(mapid).name
data modify storage rhythm_axe:lb del.score set value 0
$execute store result storage rhythm_axe:lb del.score int 1 run data get storage rhythm_axe:scores $(key).$(mapid).score
data modify storage rhythm_axe:prop dialog set value {\
type:"minecraft:confirmation",\
title:{text:"删除这份成绩？"},\
body:[\
  {type:"minecraft:plain_message",width:400,contents:[{text:"玩家："},"?"]},\
  {type:"minecraft:plain_message",width:400,contents:{text:"删除后不可恢复，排行榜会立即刷新。确定要删除这条成绩吗？"}}\
],\
can_close_with_escape:true,\
pause:false,\
yes:{label:{text:"删除"},tooltip:{text:"永久删除这条成绩"},action:{type:"run_command",command:"/function rhythm_axe:map_list/lb/del_go"}},\
no:{label:{text:"取消"},action:{type:"run_command",command:"/function rhythm_axe:map_list/lb/del_cancel"}}}
data modify storage rhythm_axe:prop dialog.body[0].contents[1] set from storage rhythm_axe:lb del.name
function rhythm_axe:utilization/dialog_show_inline with storage rhythm_axe:prop
data remove storage rhythm_axe:prop dialog
