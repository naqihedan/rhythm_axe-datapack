# 保存谱面设置：暂存副本 merge 回工作副本（一次历史快照），关闭面板回主菜单
function rhythm_axe:editor/file/begin
data modify storage rhythm_axe:maps.editor op_label set value "谱面信息修改"
data modify storage rhythm_axe:prop cursor set from storage rhythm_axe:maps.editor history_cursor
function rhythm_axe:editor/menu/map/panel/map_panel_save_ with storage rhythm_axe:prop
function rhythm_axe:editor/file/commit
function rhythm_axe:editor/refresh
data modify storage rhythm_axe:maps.editor feedback set value "已保存谱面设置"
data remove storage rhythm_axe:maps.editor panel_temp
data remove storage rhythm_axe:prop cursor
function rhythm_axe:editor/menu/main
