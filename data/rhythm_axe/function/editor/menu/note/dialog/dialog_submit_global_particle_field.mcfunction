#arg:value
# 对话框提交：用户值 + 当前 particle_group/particle_case，经 with storage 注入执行宏写回 feedback.particles
$data modify storage rhythm_axe:prop pv_value set value '$(value)'
data modify storage rhythm_axe:prop pv_group set from storage rhythm_axe:prop particle_group
data modify storage rhythm_axe:prop pv_case set from storage rhythm_axe:prop particle_case
function rhythm_axe:editor/menu/note/dialog/dialog_submit_global_particle_field_ with storage rhythm_axe:prop
data remove storage rhythm_axe:prop pv_value
data remove storage rhythm_axe:prop pv_group
data remove storage rhythm_axe:prop pv_case
