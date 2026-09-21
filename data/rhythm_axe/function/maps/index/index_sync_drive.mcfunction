# 索引自检驱动器（普通函数自递归 + 宏叶子单步）
# 前置：#idx_i=0、prop.idx_new 已清空。退出：索引遍历结束（越界）
execute if score #idx_i editor matches 100000 run return 0
execute store result storage rhythm_axe:prop i int 1 run scoreboard players get #idx_i editor
function rhythm_axe:maps/index/index_get with storage rhythm_axe:prop
execute unless data storage rhythm_axe:prop mapid run return 0
function rhythm_axe:maps/index/index_sync_leaf with storage rhythm_axe:prop
data remove storage rhythm_axe:prop mapid
scoreboard players add #idx_i editor 1
function rhythm_axe:maps/index/index_sync_drive
