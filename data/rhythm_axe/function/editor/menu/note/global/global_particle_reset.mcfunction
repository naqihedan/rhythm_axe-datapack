# 全局击打视效：恢复进入面板时的备份并刷新
data modify storage rhythm_axe:feedback particles set from storage rhythm_axe:prop particle_backup
data modify storage rhythm_axe:maps.editor feedback set value "已重置为进入时状态"
data modify storage rhythm_axe:maps.editor no_undo set value 1b
function rhythm_axe:editor/menu/note/global/global_particle_panel
