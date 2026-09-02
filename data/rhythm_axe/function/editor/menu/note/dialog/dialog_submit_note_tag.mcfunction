#arg:value
# 对话框提交：音符标签写入暂存 editing.temp.custom_tag，刷新面板
$data modify storage rhythm_axe:maps.editor editing.temp.custom_tag set value '$(value)'
function rhythm_axe:editor/menu/note/panel/note_panel
