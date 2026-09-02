#arg:value
# 对话框提交：指令写入暂存 commands[cmd_target]（引号用 \" 转义输入）
data modify storage rhythm_axe:prop cmd_target set from storage rhythm_axe:maps.editor editing.cmd_target
$data modify storage rhythm_axe:prop cmd_value set value '$(value)'
function rhythm_axe:editor/menu/event/dialog/dialog_submit_event_cmd_ with storage rhythm_axe:prop
data remove storage rhythm_axe:prop cmd_target
data remove storage rhythm_axe:prop cmd_value
