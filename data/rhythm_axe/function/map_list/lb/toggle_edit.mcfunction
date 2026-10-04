# 排行榜的【编辑成绩】/【完成编辑】（11705）：切换**全局**开关 map_list.lb_edit
#   缺省（无此键）= 隐藏（默认不显示 [x]）；开着时每个名次行前面出现 [x]
# 点完用 map_list.lb_mapid（由 leaderboard.mcfunction 写入）重绘当前这张谱面的排行榜，
#   不依赖 prop.mapid（那个在 leaderboard 渲染收尾时就被清掉了）
execute unless data storage rhythm_axe:map_list lb_mapid run return fail
# ⚠️ 切换必须先记到临时分数：写成「先 remove（若开着）→ 再 unless 就 set」的话，
#   remove 之后那个 unless 条件又重新成立 ⇒ 永远只能是"开"，第二下点不掉（2026-10-04 实测踩到）。
scoreboard players set #lb_toggle menu 0
execute if data storage rhythm_axe:map_list {lb_edit:1b} run scoreboard players set #lb_toggle menu 1
execute if score #lb_toggle menu matches 1 run data remove storage rhythm_axe:map_list lb_edit
execute if score #lb_toggle menu matches 0 run data modify storage rhythm_axe:map_list lb_edit set value 1b
execute if data storage rhythm_axe:map_list {lb_edit:1b} run tellraw @s [{"text":"[排行榜] ","color":"gold"},{"text":"已进入编辑模式：每个名次行前面出现 [x]（再点一次结束）","color":"gray"}]
execute unless data storage rhythm_axe:map_list {lb_edit:1b} run tellraw @s [{"text":"[排行榜] ","color":"gold"},{"text":"已退出编辑模式：已隐藏所有 [x]","color":"gray"}]
scoreboard players reset #lb_toggle menu
data remove storage rhythm_axe:prop mapid
data modify storage rhythm_axe:prop mapid set from storage rhythm_axe:map_list lb_mapid
function rhythm_axe:map_list/sync_lb
data remove storage rhythm_axe:prop mapid
