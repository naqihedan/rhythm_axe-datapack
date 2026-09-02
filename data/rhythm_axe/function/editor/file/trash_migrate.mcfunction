# 迁移/清理：删除旧复合结构 trash.{mapid}（旧版本用复合键；新代码用列表 trash[]）
# 检测：trash 键存在但 trash[0] 不存在 → 是旧复合结构（或空列表）→ 删除，append 时重建为列表
# ★ data get 在复合上的 store result 行为不可靠，改用 trash[0] 存在性判断
execute if data storage rhythm_axe:maps trash unless data storage rhythm_axe:maps trash[0] run data remove storage rhythm_axe:maps trash
