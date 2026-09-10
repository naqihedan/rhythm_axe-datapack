# 执行另存（41）：复制当前工作副本为 <原mapid>_copy 的未落盘工作副本并切换编辑
data modify storage rhythm_axe:prop mapid set from storage rhythm_axe:maps.editor mapid
data modify storage rhythm_axe:prop cur set from storage rhythm_axe:maps.editor history_cursor
function rhythm_axe:editor/menu/save_as/save_as_go_ with storage rhythm_axe:prop
data remove storage rhythm_axe:prop mapid
data remove storage rhythm_axe:prop cur
function rhythm_axe:editor/menu/main
