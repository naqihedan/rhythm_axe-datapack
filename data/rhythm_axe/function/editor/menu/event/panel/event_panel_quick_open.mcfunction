# 事件列表【新增一个事件点】：按播放头位置智能处理（快捷操作，直接弹指令输入框）
#   ① 播放头处**无**事件点 → 新建暂存事件点（is_new）+ 一条空指令 + 弹输入框
#      点【取消】= 什么都不发生（暂存丢弃，谱面不变）
#   ② 播放头处**已有**事件点、且其中**有**空指令 → 打开该事件点的暂存编辑，定位到最后一条空指令并弹输入框
#   ③ 播放头处**已有**事件点、但**没有**空指令 → 打开暂存编辑，追加一条空指令并弹输入框
#      ②③ 点【取消】只是丢弃暂存 ⇒ 已有事件点原封不动
# ★ 取消统一走 dialog/dialog_cancel 的 editing.quick_flow 分支（丢弃暂存 + 回事件列表）
data modify storage rhythm_axe:prop cursor set from storage rhythm_axe:maps.editor history_cursor
data modify storage rhythm_axe:prop list_name set value "events"
data modify storage rhythm_axe:prop index set value 0
data modify storage rhythm_axe:prop target_time set from storage rhythm_axe:maps.editor playhead
data remove storage rhythm_axe:prop found_index
function rhythm_axe:editor/util/find_by_time

execute if data storage rhythm_axe:prop found_index run data modify storage rhythm_axe:prop index set from storage rhythm_axe:prop found_index
execute if data storage rhythm_axe:prop found_index run function rhythm_axe:editor/menu/event/panel/event_panel_quick_existing with storage rhythm_axe:prop
execute unless data storage rhythm_axe:prop found_index run function rhythm_axe:editor/menu/event/panel/event_panel_quick_new

data remove storage rhythm_axe:prop cursor
data remove storage rhythm_axe:prop list_name
data remove storage rhythm_axe:prop index
data remove storage rhythm_axe:prop target_time
data remove storage rhythm_axe:prop found_index
data remove storage rhythm_axe:prop empty_index