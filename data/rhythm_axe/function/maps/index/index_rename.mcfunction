#arg: old, new
# 谱面改名（editor/menu/map/ops/map_rename）：索引同步 = 旧名出队 + 新名入队。
# ⚠️ 顺序变化：改名后的谱面会移到索引末尾（总表按索引顺序显示，改名相当于重新登记）。
#   未在索引里的旧名（索引机制上线前就存在的谱面）也没问题：出队是空操作，新名照常入队。
$function rhythm_axe:maps/index/index_remove {mapid:"$(old)"}
$function rhythm_axe:maps/index/index_add {mapid:"$(new)"}
