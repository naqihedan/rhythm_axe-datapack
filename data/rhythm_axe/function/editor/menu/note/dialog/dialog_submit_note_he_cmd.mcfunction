#arg:value,spawn,tick,bad,good_early,perfect_early,perfect,perfect_late,good_late,miss,damage
# 对话框提交（第一步）：把目标索引与输入值写入 prop，再调第二步写回
data modify storage rhythm_axe:prop he_cur set from storage rhythm_axe:maps.editor editing.he_cur
$data modify storage rhythm_axe:prop he_cmd set value '$(value)'
$data modify storage rhythm_axe:prop he_spawn set value $(spawn)
$data modify storage rhythm_axe:prop he_tick set value $(tick)
$data modify storage rhythm_axe:prop he_bad set value $(bad)
$data modify storage rhythm_axe:prop he_good_early set value $(good_early)
$data modify storage rhythm_axe:prop he_perfect_early set value $(perfect_early)
$data modify storage rhythm_axe:prop he_perfect set value $(perfect)
$data modify storage rhythm_axe:prop he_perfect_late set value $(perfect_late)
$data modify storage rhythm_axe:prop he_good_late set value $(good_late)
$data modify storage rhythm_axe:prop he_miss set value $(miss)
$data modify storage rhythm_axe:prop he_damage set value $(damage)
function rhythm_axe:editor/menu/note/dialog/dialog_submit_note_he_cmd_ with storage rhythm_axe:prop