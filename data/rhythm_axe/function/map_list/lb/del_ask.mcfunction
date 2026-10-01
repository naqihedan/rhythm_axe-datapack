#arg:i
# 排行榜名次行 [x] 的点击入口（按钮值 11801~11810 = 名次 1..10；i = 名次-1 = 渲染快照下标）
# ★ 用**渲染时存下的快照** rhythm_axe:lb.rows 回查是谁，而不是重算排名 ——
#   重算在「渲染后榜单变了」时会删错人；快照保证点的一定是屏幕上那一行。
$data modify storage rhythm_axe:prop key set from storage rhythm_axe:lb rows[$(i)].key
$data modify storage rhythm_axe:prop mapid set from storage rhythm_axe:lb rows[$(i)].mapid
# 快照过期（点了旧聊天行的按钮 / 榜单已刷新）→ 提示后什么都不做
execute unless data storage rhythm_axe:prop key run tellraw @s [{"text":"[排行榜] ","color":"gold"},{"text":"这条成绩已经不在了（排行榜可能已刷新）","color":"yellow"}]
execute unless data storage rhythm_axe:prop key run return fail
function rhythm_axe:map_list/lb/del_read with storage rhythm_axe:prop
data remove storage rhythm_axe:prop key
data remove storage rhythm_axe:prop mapid
