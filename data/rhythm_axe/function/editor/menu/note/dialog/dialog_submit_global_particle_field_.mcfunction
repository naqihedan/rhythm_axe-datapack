#arg:pv_value,pv_group,pv_case
# 执行宏：写回 feedback.particles[particle_group].particle_case 并刷新全局击打视效详情
$data modify storage rhythm_axe:feedback particles[$(pv_group)].$(pv_case) set value "$(pv_value)"
data modify storage rhythm_axe:maps.editor feedback set value "已更新全局击打视效"
data modify storage rhythm_axe:maps.editor no_undo set value 1b
function rhythm_axe:editor/menu/note/global/global_particle_detail
