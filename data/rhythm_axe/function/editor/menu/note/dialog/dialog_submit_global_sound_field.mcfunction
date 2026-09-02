#arg:value,sound_group,sound_case
$data modify storage rhythm_axe:feedback sounds[$(sound_group)].$(sound_case) set value "$(value)"
data modify storage rhythm_axe:maps.editor feedback set value "已更新全局击打音效"
data modify storage rhythm_axe:maps.editor no_undo set value 1b
function rhythm_axe:editor/menu/note/global/global_sound_detail
