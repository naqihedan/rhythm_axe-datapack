#arg:key,mapid
# 从 scores_index.<mapid> 名单里摘掉一个人的 key（列表没有「按值删除」⇒ 逐个比较重建）
# 走法：读人数 → 驱动器逐项交给叶子 → 叶子跳过要删的那个、其余追加到 rhythm_axe:lb.rebuilt → 盖回名单
data remove storage rhythm_axe:lb tmp
data modify storage rhythm_axe:lb rebuilt set value []
scoreboard players set #lb_rn menu 0
$execute store result score #lb_rn menu run data get storage rhythm_axe:scores_index $(mapid)
scoreboard players set #lb_ri menu 0
execute if score #lb_rn menu matches 1.. run function rhythm_axe:map_list/lb/del_rebuild_drive
$data modify storage rhythm_axe:scores_index $(mapid) set from storage rhythm_axe:lb rebuilt
data remove storage rhythm_axe:lb rebuilt
