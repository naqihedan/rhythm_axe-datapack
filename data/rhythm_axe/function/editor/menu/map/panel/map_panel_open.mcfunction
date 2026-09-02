# 打开谱面设置面板：从当前工作副本初始化暂存副本 panel_temp（只含面板可编辑的根字段）
data modify storage rhythm_axe:maps.editor current_panel set value 2
data modify storage rhythm_axe:prop cursor set from storage rhythm_axe:maps.editor history_cursor
function rhythm_axe:editor/menu/map/panel/map_panel_init with storage rhythm_axe:prop
data remove storage rhythm_axe:prop cursor
function rhythm_axe:editor/menu/map/panel/map_panel
