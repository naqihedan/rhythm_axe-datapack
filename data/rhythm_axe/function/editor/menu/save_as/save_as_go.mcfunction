# 执行另存（41）：工作副本写入 <mapid>_副本 并切换编辑
data modify storage rhythm_axe:prop mapid set from storage rhythm_axe:maps.editor mapid
data modify storage rhythm_axe:prop cur set from storage rhythm_axe:maps.editor history_cursor
function rhythm_axe:editor/menu/save_as/save_as_go_ with storage rhythm_axe:prop
data remove storage rhythm_axe:prop mapid
data remove storage rhythm_axe:prop cur
function rhythm_axe:editor/menu/main
