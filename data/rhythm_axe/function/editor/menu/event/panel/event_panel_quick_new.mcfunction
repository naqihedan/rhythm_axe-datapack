# 播放头处**没有**事件点：新建暂存事件点（含一条空指令）并直接弹出指令输入框。
# ★ 快捷操作：省掉「添加一个指令」+「点编辑」两步。
# ★ 取消语义：事件点此时还没写进谱面（要等【确认新增】）⇒ 对话框点【取消】= 什么都不发生，
#   由 dialog/dialog_cancel 按 editing.quick_flow + editing.is_new 分支丢弃暂存并回到事件列表。
data modify storage rhythm_axe:maps.editor current_panel set value 6
data modify storage rhythm_axe:maps.editor editing set value {}
data modify storage rhythm_axe:maps.editor editing.is_new set value 1b
execute store result storage rhythm_axe:maps.editor editing.temp.time int 1 run data get storage rhythm_axe:maps.editor playhead
data modify storage rhythm_axe:maps.editor editing.temp.commands set value []
function rhythm_axe:editor/menu/event/panel/event_panel_quick_cmd