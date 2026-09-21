#arg: mapid
# 谱面索引出队：移除索引里第一个等于 mapid 的项（重复项由 index_sync 兜底）。
# 调用点：editor/file/delete（谱面移入回收站，不再是"可玩谱面"）。
$data modify storage rhythm_axe:prop old_id set value "$(mapid)"
scoreboard players set #idx_i editor 0
scoreboard players set #idx_stop editor 0
function rhythm_axe:maps/index/index_remove_drive
data remove storage rhythm_axe:prop old_id
