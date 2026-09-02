#arg:cmd_target,cmd_value
# 写指令到暂存副本并刷新面板
$data modify storage rhythm_axe:maps.editor editing.temp.commands[$(cmd_target)] set value '$(cmd_value)'
data modify storage rhythm_axe:maps.editor feedback set value "指令已修改（确认后生效）"
data modify storage rhythm_axe:maps.editor no_undo set value 1b
function rhythm_axe:editor/menu/event/panel/event_panel
