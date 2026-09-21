#arg: mapid
# 谱面索引入队（幂等：已在索引里就不重复添加）。
# 调用点：editor/file/save（保存谱面）、editor/menu/trash/trash_restore_go（回收站还原）、
#         maps/index/index_rename（改名后的新名）、maps/index/index_bootstrap（一次性导入）。
# 调用方式：function rhythm_axe:maps/index/index_add {mapid:"xx"}（内联宏参）
$data modify storage rhythm_axe:prop new_id set value "$(mapid)"
scoreboard players set #idx_i editor 0
scoreboard players set #idx_stop editor 0
function rhythm_axe:maps/index/index_add_drive
# 未命中重复（#idx_stop != 1）⇒ 追加到索引末尾；index 不存在时 append 会自动建表
execute if score #idx_stop editor matches 0 run data modify storage rhythm_axe:maps index append from storage rhythm_axe:prop new_id
data remove storage rhythm_axe:prop new_id
