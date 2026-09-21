# 索引查重驱动器（普通函数自递归 + 宏叶子单步；避开 26.x 宏递归"幽灵重跑"）
# 前置：#idx_i=0、#idx_stop=0；prop.new_id 已写。
# 退出：#idx_stop=1（命中重复）或索引遍历结束（越界）
#   注：`execute if score ... matches 100000 run return 0` 是防呆上限（驱动器被绕过入口直调时不会失控）
execute if score #idx_stop editor matches 1 run return 0
execute if score #idx_i editor matches 100000 run return 0
execute store result storage rhythm_axe:prop i int 1 run scoreboard players get #idx_i editor
function rhythm_axe:maps/index/index_get with storage rhythm_axe:prop
execute unless data storage rhythm_axe:prop mapid run return 0
function rhythm_axe:maps/index/index_add_leaf with storage rhythm_axe:prop
execute if score #idx_stop editor matches 1 run return 0
data remove storage rhythm_axe:prop mapid
scoreboard players add #idx_i editor 1
function rhythm_axe:maps/index/index_add_drive
