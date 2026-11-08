#arg:cursor,index
# 播放头处已有事件点：打开暂存编辑（不渲染），然后交给 quick_cmd 定位/追加空指令并弹输入框。
# ★ 内联 event_panel_open 的逻辑但不调它的 event_panel（避免清屏渲染两次）。
# ★ 播放头本来就停在该事件点时间上（查找用的就是 playhead）⇒ 无需再挪播放头。
data modify storage rhythm_axe:maps.editor current_panel set value 6
data modify storage rhythm_axe:maps.editor editing set value {}
$data modify storage rhythm_axe:maps.editor editing.ref set value $(index)
$data modify storage rhythm_axe:maps.editor editing.temp set from storage rhythm_axe:maps.editor history[$(cursor)].events[$(index)]
# 旧事件可能缺字段，补缺省值
execute unless data storage rhythm_axe:maps.editor editing.temp.time run data modify storage rhythm_axe:maps.editor editing.temp.time set value 0
execute unless data storage rhythm_axe:maps.editor editing.temp.commands run data modify storage rhythm_axe:maps.editor editing.temp.commands set value []
function rhythm_axe:editor/menu/event/panel/event_panel_quick_cmd