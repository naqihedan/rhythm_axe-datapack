# 保存谱面（主菜单）：组装 prop 参数调 file/save
data modify storage rhythm_axe:prop mapid set from storage rhythm_axe:maps.editor mapid
data modify storage rhythm_axe:prop cur set from storage rhythm_axe:maps.editor history_cursor
function rhythm_axe:editor/file/save with storage rhythm_axe:prop
data modify storage rhythm_axe:maps.editor feedback set value "已保存谱面"
data modify storage rhythm_axe:maps.editor no_undo set value 1b
data remove storage rhythm_axe:prop mapid
data remove storage rhythm_axe:prop cur
function rhythm_axe:editor/menu/main
