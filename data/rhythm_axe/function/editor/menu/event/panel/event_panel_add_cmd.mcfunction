# 在末尾追加一条空指令（只改暂存 editing.temp），并**立即弹出输入框**
# 快捷操作：省掉再点一次【编辑】。取消时只回滚这一条（editing.quick_add = 刚追加的下标）。
# ★ append 到不存在的路径会失败：旧事件点可能缺 commands 键，先兜底补空列表。
# ★ 先清掉可能残留的 quick_flow（那是【新增一个事件点】入口的标记），避免取消语义串味。
data remove storage rhythm_axe:maps.editor editing.quick_flow
execute unless data storage rhythm_axe:maps.editor editing.temp.commands run data modify storage rhythm_axe:maps.editor editing.temp.commands set value []
data modify storage rhythm_axe:maps.editor editing.temp.commands append value ""
execute store result score #qc_len editor run data get storage rhythm_axe:maps.editor editing.temp.commands
scoreboard players remove #qc_len editor 1
execute store result storage rhythm_axe:maps.editor editing.cmd_target int 1 run scoreboard players get #qc_len editor
data modify storage rhythm_axe:maps.editor editing.quick_add set from storage rhythm_axe:maps.editor editing.cmd_target
scoreboard players reset #qc_len editor
function rhythm_axe:editor/menu/event/panel/event_panel
dialog show @s rhythm_axe:editor_event_cmd
