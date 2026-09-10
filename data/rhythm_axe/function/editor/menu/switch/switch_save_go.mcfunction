# 10001 保存当前谱面并切换：先保存当前工作副本，再走 switch_go 打开 pending_mapid
data modify storage rhythm_axe:prop mapid set from storage rhythm_axe:maps.editor mapid
data modify storage rhythm_axe:prop cur set from storage rhythm_axe:maps.editor history_cursor
function rhythm_axe:editor/file/save with storage rhythm_axe:prop
data remove storage rhythm_axe:prop mapid
data remove storage rhythm_axe:prop cur
function rhythm_axe:editor/menu/switch/switch_go
