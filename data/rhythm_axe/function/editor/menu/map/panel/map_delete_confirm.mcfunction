# 删除谱面确认面板（current_panel=16）：显示 {标题}-{作者}-{mapid} + 确认/取消
# 取消（136）回谱面设置；确认（135）map_delete_go 移入回收站后退出编辑器
execute store result storage rhythm_axe:prop cursor int 1 run data get storage rhythm_axe:maps.editor history_cursor
data modify storage rhythm_axe:prop mapid set from storage rhythm_axe:maps.editor mapid
function rhythm_axe:editor/menu/map/panel/map_delete_confirm_ with storage rhythm_axe:prop
data remove storage rhythm_axe:prop cursor
data remove storage rhythm_axe:prop mapid
