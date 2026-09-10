# 保存后另存（40/101）：先把当前改动保存到原 mapid，再走 save_as_go 生成 _copy 未落盘副本
data modify storage rhythm_axe:prop mapid set from storage rhythm_axe:maps.editor mapid
data modify storage rhythm_axe:prop cur set from storage rhythm_axe:maps.editor history_cursor
function rhythm_axe:editor/file/save with storage rhythm_axe:prop
data remove storage rhythm_axe:prop mapid
data remove storage rhythm_axe:prop cur
function rhythm_axe:editor/menu/save_as/save_as_go
