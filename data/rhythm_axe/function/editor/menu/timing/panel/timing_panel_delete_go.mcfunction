# 删除时间点（一次历史快照）
function rhythm_axe:editor/file/begin
data modify storage rhythm_axe:maps.editor op_label set value "删除时间点"
data modify storage rhythm_axe:prop cursor set from storage rhythm_axe:maps.editor history_cursor
data modify storage rhythm_axe:prop index set from storage rhythm_axe:maps.editor editing.ref
function rhythm_axe:editor/timing/delete_ with storage rhythm_axe:prop
function rhythm_axe:editor/file/commit
function rhythm_axe:editor/refresh
data modify storage rhythm_axe:maps.editor feedback set value "已删除时间点"
data remove storage rhythm_axe:maps.editor editing
data remove storage rhythm_axe:prop cursor
data remove storage rhythm_axe:prop index
function rhythm_axe:editor/menu/timing/list/timing_list_open
