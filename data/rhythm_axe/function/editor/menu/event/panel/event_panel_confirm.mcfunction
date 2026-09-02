# 确认事件点修改：暂存 editing.temp 写回工作副本（移除原元素后按新 time 重插，一次历史快照）
function rhythm_axe:editor/file/begin
data modify storage rhythm_axe:maps.editor op_label set value "修改事件"
data modify storage rhythm_axe:prop cursor set from storage rhythm_axe:maps.editor history_cursor
data modify storage rhythm_axe:prop index set from storage rhythm_axe:maps.editor editing.ref
function rhythm_axe:editor/menu/event/panel/event_panel_confirm_ with storage rhythm_axe:prop
function rhythm_axe:editor/file/commit
function rhythm_axe:editor/refresh
data modify storage rhythm_axe:maps.editor feedback set value "已修改事件点"
data remove storage rhythm_axe:maps.editor editing
data remove storage rhythm_axe:prop cursor
data remove storage rhythm_axe:prop index
data remove storage rhythm_axe:prop tmp_elem
data remove storage rhythm_axe:prop new_time
data remove storage rhythm_axe:prop list_name
data remove storage rhythm_axe:prop insert_mode
data remove storage rhythm_axe:prop insert_index
function rhythm_axe:editor/menu/event/list/event_list_open
