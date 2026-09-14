# [已废弃 2026-09-14 D1b] 旧版线性插入点查找的子函数；insert_find 已改为指数+二分，不再调用
# 游标 +1 后继续查找插入点
execute store result score #index editor run data get storage rhythm_axe:prop index
scoreboard players add #index editor 1
execute store result storage rhythm_axe:prop index int 1 run scoreboard players get #index editor
function rhythm_axe:editor/util/insert_find with storage rhythm_axe:prop
