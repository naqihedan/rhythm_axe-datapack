#arg:value
# 对话框提交：音符标签写入暂存 editing.temp.custom_tag，刷新面板；批量时打 batch_set 标记
$data modify storage rhythm_axe:maps.editor editing.temp.custom_tag set value '$(value)'
execute if data storage rhythm_axe:maps.editor editing.batch run data modify storage rhythm_axe:maps.editor editing.batch_set.custom_tag set value 1b
function rhythm_axe:editor/menu/note/panel/note_panel
