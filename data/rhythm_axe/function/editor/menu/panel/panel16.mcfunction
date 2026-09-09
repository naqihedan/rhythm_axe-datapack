# 面板 16：删除谱面确认（135 确认删除 / 136 取消返回主菜单）。map_delete_confirm_ 设 current_panel=16。
# 入口白名单守卫
execute unless score #click_value editor matches 135..136 run function rhythm_axe:editor/menu/wrong_panel
execute unless score #click_value editor matches 135..136 run return fail

# 135 确认删除：重新读 mapid 进 prop 再调（确认面板已清 prop）
execute if score #click_value editor matches 135 run data modify storage rhythm_axe:prop mapid set from storage rhythm_axe:maps.editor mapid
execute if score #click_value editor matches 135 run function rhythm_axe:editor/menu/map/panel/map_delete_go with storage rhythm_axe:prop
execute if score #click_value editor matches 135 run data remove storage rhythm_axe:prop mapid
# 136 取消
execute if score #click_value editor matches 136 run function rhythm_axe:editor/menu/main
