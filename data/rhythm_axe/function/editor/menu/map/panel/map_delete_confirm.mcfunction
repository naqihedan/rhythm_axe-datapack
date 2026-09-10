# 删除谱面确认面板（current_panel=16）：显示 {标题}-{作者}-{mapid} + 确认/取消
# 取消（136）回谱面设置；确认（135）map_delete_go 移入回收站后退出编辑器
# ⚠️ 会话缺少 mapid 时给明确提示：否则 prop.mapid 写不进去，下面的宏函数（#arg: cursor, mapid）
#    会因宏参数缺失而静默实例化失败 → 表现就是“点【删除谱面】没反应”
execute unless data storage rhythm_axe:maps.editor mapid run tellraw @s [{"text":"[编辑器] 当前会话缺少谱面 id（mapid），无法删除","color":"red"}]
execute unless data storage rhythm_axe:maps.editor mapid run tellraw @s [{"text":"请退出编辑器后重新打开该谱面再试","color":"yellow"}]
execute unless data storage rhythm_axe:maps.editor mapid run return fail
execute store result storage rhythm_axe:prop cursor int 1 run data get storage rhythm_axe:maps.editor history_cursor
data modify storage rhythm_axe:prop mapid set from storage rhythm_axe:maps.editor mapid
function rhythm_axe:editor/menu/map/panel/map_delete_confirm_ with storage rhythm_axe:prop
data remove storage rhythm_axe:prop cursor
data remove storage rhythm_axe:prop mapid
