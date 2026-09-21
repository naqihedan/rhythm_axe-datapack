# 索引自检：剔掉"正式存储已不存在"的条目，按遍历顺序重建整个索引（顺带去重）。
# 入口：/function rhythm_axe:maps/index/index_sync（大厅每次打开前也会自动跑一次）
# 保留条件：rhythm_axe:maps.<mapid> 存在 id 字段（与 editor/open、start_of_game 同一判据）
data remove storage rhythm_axe:prop idx_new
scoreboard players set #idx_i editor 0
function rhythm_axe:maps/index/index_sync_drive
# 重建（全空则删掉索引键）
execute if data storage rhythm_axe:prop idx_new run data modify storage rhythm_axe:maps index set from storage rhythm_axe:prop idx_new
execute unless data storage rhythm_axe:prop idx_new run data remove storage rhythm_axe:maps index
data remove storage rhythm_axe:prop idx_new
