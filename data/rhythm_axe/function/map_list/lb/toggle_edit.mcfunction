# 排行榜的【编辑成绩】/【完成编辑】（11705）：切换**全局**开关 map_list.lb_edit
#   缺省（无此键）= 隐藏（默认不显示 [x]）；开着时每个名次行前面出现 [x]
# 点完用 map_list.lb_mapid（由 leaderboard.mcfunction 写入）重绘当前这张谱面的排行榜，
#   不依赖 prop.mapid（那个在 leaderboard 渲染收尾时就被清掉了）
execute unless data storage rhythm_axe:map_list lb_mapid run return fail
execute if data storage rhythm_axe:map_list {lb_edit:1b} run data remove storage rhythm_axe:map_list lb_edit
execute unless data storage rhythm_axe:map_list lb_edit run data modify storage rhythm_axe:map_list lb_edit set value 1b
execute if data storage rhythm_axe:map_list {lb_edit:1b} run tellraw @s [{"text":"[排行榜] ","color":"gold"},{"text":"已进入编辑模式：每个名次行前面出现 [x]（再点一次结束）","color":"gray"}]
execute unless data storage rhythm_axe:map_list {lb_edit:1b} run tellraw @s [{"text":"[排行榜] ","color":"gold"},{"text":"已退出编辑模式：已隐藏所有 [x]","color":"gray"}]
data remove storage rhythm_axe:prop mapid
data modify storage rhythm_axe:prop mapid set from storage rhythm_axe:map_list lb_mapid
function rhythm_axe:map_list/sync_lb
data remove storage rhythm_axe:prop mapid
