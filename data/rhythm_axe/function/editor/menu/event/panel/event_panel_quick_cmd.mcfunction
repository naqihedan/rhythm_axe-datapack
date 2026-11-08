# 快速指令：在当前暂存编辑里定位「最后一条空指令」，没有就追加一条，然后直接弹输入框 + 渲染面板。
# 前置：editing.temp.time / editing.temp.commands 已就绪（quick_new / quick_existing 已备好）
# ★ 快捷操作：省掉「添加一个指令」+「点编辑」两步。
#
# 取消标记（由 dialog_cancel_event_cmd 读取）：
#   editing.quick_flow —— 本次对话框是「快捷操作」弹出的（事件列表【新增一个事件点】）
#   editing.quick_add  —— 本次**追加**了空指令，值为其下标；取消时只删这一条
#   优先级：quick_add → 模式 3；quick_flow+is_new → 模式 1；quick_flow → 模式 2
execute unless data storage rhythm_axe:maps.editor editing.temp.commands run data modify storage rhythm_axe:maps.editor editing.temp.commands set value []
data remove storage rhythm_axe:maps.editor editing.quick_add
function rhythm_axe:editor/menu/event/panel/event_panel_find_empty
# 没有空指令 → 追加一条（新下标 = 追加后的长度 - 1），并记进 quick_add
execute unless data storage rhythm_axe:prop empty_index run data modify storage rhythm_axe:maps.editor editing.temp.commands append value ""
execute unless data storage rhythm_axe:prop empty_index run execute store result score #qc_len editor run data get storage rhythm_axe:maps.editor editing.temp.commands
execute unless data storage rhythm_axe:prop empty_index run scoreboard players remove #qc_len editor 1
execute unless data storage rhythm_axe:prop empty_index run execute store result storage rhythm_axe:maps.editor editing.cmd_target int 1 run scoreboard players get #qc_len editor
execute unless data storage rhythm_axe:prop empty_index run data modify storage rhythm_axe:maps.editor editing.quick_add set from storage rhythm_axe:maps.editor editing.cmd_target
execute unless data storage rhythm_axe:prop empty_index run scoreboard players reset #qc_len editor
execute if data storage rhythm_axe:prop empty_index run data modify storage rhythm_axe:maps.editor editing.cmd_target set from storage rhythm_axe:prop empty_index
data remove storage rhythm_axe:prop empty_index
# 标记这次是「快捷操作」发起
data modify storage rhythm_axe:maps.editor editing.quick_flow set value 1b
function rhythm_axe:editor/menu/event/panel/event_panel
dialog show @s rhythm_axe:editor_event_cmd