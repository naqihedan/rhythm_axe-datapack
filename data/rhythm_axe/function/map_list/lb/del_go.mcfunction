# 确认对话框【删除】：摘名单 → 删条目 → 反馈 → 立即重绘排行榜
# 前置：rhythm_axe:lb.del = {key,mapid,name,score}（由 lb/del_read 写入）
execute unless data storage rhythm_axe:lb del.key run return fail
data modify storage rhythm_axe:prop key set from storage rhythm_axe:lb del.key
data modify storage rhythm_axe:prop mapid set from storage rhythm_axe:lb del.mapid
data modify storage rhythm_axe:prop name set from storage rhythm_axe:lb del.name
# 摘名单必须一起做：留着孤儿 key 会让排行榜把它算进人数、取分时为 0
function rhythm_axe:map_list/lb/del_rebuild with storage rhythm_axe:prop
function rhythm_axe:play/highscore/clear_del with storage rhythm_axe:prop
data remove storage rhythm_axe:lb del
function rhythm_axe:map_list/lb/del_feedback with storage rhythm_axe:prop
data remove storage rhythm_axe:prop key
data remove storage rhythm_axe:prop name
# 重绘（共享页：点击者必刷，其它正在看排行榜的人一起刷；排行榜自己会重建 rows 快照）
function rhythm_axe:map_list/sync_lb
data remove storage rhythm_axe:prop mapid
