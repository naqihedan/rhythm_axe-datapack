# 面板 16：删除谱面确认。规范v2：行100: 10001 确认删除 / 10002 取消返回主菜单。
execute unless score #click_value editor matches 10000..10099 run function rhythm_axe:editor/menu/wrong_panel
execute unless score #click_value editor matches 10000..10099 run return fail
# 101 确认删除：重新读 mapid 进 prop 再调（确认面板已清 prop）
execute if score #click_value editor matches 10001 unless data storage rhythm_axe:maps.editor mapid run tellraw @s [{"text":"[编辑器] 当前会话缺少谱面 id（mapid），无法删除；请退出编辑器后重新打开该谱面","color":"red"}]
execute if score #click_value editor matches 10001 run data modify storage rhythm_axe:prop mapid set from storage rhythm_axe:maps.editor mapid
execute if score #click_value editor matches 10001 run function rhythm_axe:editor/menu/map/panel/map_delete_go with storage rhythm_axe:prop
execute if score #click_value editor matches 10001 run data remove storage rhythm_axe:prop mapid
# 102 取消返回主菜单
execute if score #click_value editor matches 10002 run function rhythm_axe:editor/menu/main
