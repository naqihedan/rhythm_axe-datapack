# 索引出队驱动器（普通函数自递归 + 宏叶子单步）
# 前置：#idx_i=0、#idx_stop=0；prop.old_id 已写。退出：#idx_stop=1（已删）或索引遍历结束
execute if score #idx_stop editor matches 1 run return 0
execute if score #idx_i editor matches 100000 run return 0
execute store result storage rhythm_axe:prop i int 1 run scoreboard players get #idx_i editor
function rhythm_axe:maps/index/index_get with storage rhythm_axe:prop
execute unless data storage rhythm_axe:prop mapid run return 0
function rhythm_axe:maps/index/index_remove_leaf with storage rhythm_axe:prop
execute if score #idx_stop editor matches 1 run return 0
data remove storage rhythm_axe:prop mapid
scoreboard players add #idx_i editor 1
function rhythm_axe:maps/index/index_remove_drive
