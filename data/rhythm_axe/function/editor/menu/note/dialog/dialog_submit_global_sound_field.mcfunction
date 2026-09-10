#arg:value
# 对话框提交：用户值 + 当前 sound_group/sound_case，经 with storage 注入执行宏写回 feedback.sounds
# 注：json 只能提供用户输入，sound_group/case 存于 prop（打开对话框前由面板设好），故在此复制后 with 注入。
$data modify storage rhythm_axe:prop gv_value set value '$(value)'
data modify storage rhythm_axe:prop gv_group set from storage rhythm_axe:prop sound_group
data modify storage rhythm_axe:prop gv_case set from storage rhythm_axe:prop sound_case
function rhythm_axe:editor/menu/note/dialog/dialog_submit_global_sound_field_ with storage rhythm_axe:prop
data remove storage rhythm_axe:prop gv_value
data remove storage rhythm_axe:prop gv_group
data remove storage rhythm_axe:prop gv_case
