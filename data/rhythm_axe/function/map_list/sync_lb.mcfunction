# 共享大厅·同步排行榜：排行榜页显示的谱面（map_list.lb_mapid）与成绩是全局的，
# 打开 / 刷新 / 删成绩 / 切「编辑成绩」都要让**正在看排行榜的人**一起更新
# 前置：prop.mapid = 要刷的谱面（调用方先写好；本函数只管渲染与分发）
# 同 sync_list：点击者无条件刷，其它人只在「正在看排行榜 + 不在编辑器 + 不在游玩」时刷
tag @s add ml_self
function rhythm_axe:map_list/maps/leaderboard with storage rhythm_axe:prop
execute as @a[tag=lb_view,tag=!ml_self,tag=!editor_active,team=!player] run function rhythm_axe:map_list/maps/leaderboard with storage rhythm_axe:prop
tag @s remove ml_self
