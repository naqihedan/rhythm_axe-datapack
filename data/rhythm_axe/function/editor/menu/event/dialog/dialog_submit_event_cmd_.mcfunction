#arg:cmd_target,cmd_value
# 写入指令到暂存副本 editing.temp.commands[cmd_target]，然后回到事件面板（暂存状态，【确认/确认新增】才落盘）
$data modify storage rhythm_axe:maps.editor editing.temp.commands[$(cmd_target)] set value '$(cmd_value)'
# ★ 2026-11-08：写入成功 = 「快捷操作」流程结束（这次对话框不再需要取消回滚），清掉标记，
#   之后若再点【编辑】【添加一个指令】等弹出的对话框，取消语义按新入口重新判定。
data remove storage rhythm_axe:maps.editor editing.quick_flow
data remove storage rhythm_axe:maps.editor editing.quick_add
data modify storage rhythm_axe:maps.editor feedback set value "指令已修改（确认后生效）"
data modify storage rhythm_axe:maps.editor no_undo set value 1b
function rhythm_axe:editor/menu/event/panel/event_panel
