# 谱面索引一次性导入（幂等，可重复执行）
# 用法：/function rhythm_axe:maps/index/index_bootstrap
# 用途：索引机制上线前就已存在的谱面没有登记过，跑一次把它们补进总表。
#   之后新谱面在【保存谱面】时会自动入队，不需要再跑本函数。
#   登记了不存在的谱面不会出错：大厅打开时的 index_sync 会剔除。
#   （下面这份清单 = 本模板存档 2026-09-19 时点已有的谱面；换存档时可自行增删行）
function rhythm_axe:maps/index/index_add {mapid:"easingtest"}
function rhythm_axe:maps/index/index_add {mapid:"follow_point"}
function rhythm_axe:maps/index/index_add {mapid:"lament_rain"}
function rhythm_axe:maps/index/index_add {mapid:"new_rename"}
function rhythm_axe:maps/index/index_add {mapid:"stress"}
function rhythm_axe:maps/index/index_add {mapid:"test"}
