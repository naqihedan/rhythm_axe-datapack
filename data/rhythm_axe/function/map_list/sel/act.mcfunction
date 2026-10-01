# 操作行三个按钮的统一入口（#sel_act = 1 游玩 / 2 编辑 / 3 排行榜）
# 作用对象 = **全局选中**的谱面（rhythm_axe:map_list.sel，字符串 mapid）；没选中 → 提示后什么都不做
# 说明：这里不做「谱面还在不在」的检查，交给既有入口（start_of_game 会提示找不到谱面、editor 有自己的判断）
execute unless data storage rhythm_axe:map_list sel run tellraw @s [{"text":"[大厅] ","color":"gold"},{"text":"先在上面的列表里点 ▶ 选中一张谱面","color":"gray"}]
execute unless data storage rhythm_axe:map_list sel run return fail
data remove storage rhythm_axe:prop mapid
data modify storage rhythm_axe:prop mapid set from storage rhythm_axe:map_list sel
execute if score #sel_act menu matches 1 run function rhythm_axe:map_list/maps/play with storage rhythm_axe:prop
execute if score #sel_act menu matches 2 run function rhythm_axe:map_list/maps/edit with storage rhythm_axe:prop
# 排行榜是共享页：打开/刷新要同步给所有“正在看排行榜”的人（见 map_list/sync_lb）
execute if score #sel_act menu matches 3 run function rhythm_axe:map_list/sync_lb
data remove storage rhythm_axe:prop mapid
