# 批量应用驱动器（普通函数，防宏递归幽灵）：逐个 batch id 调用宏叶子应用增量
# 前置：#bidx / #btotal（editor 计分板）、prop.cursor 指向工作副本
execute if score #bidx editor < #btotal editor run execute store result storage rhythm_axe:prop idx int 1 run scoreboard players get #bidx editor
execute if score #bidx editor < #btotal editor run function rhythm_axe:editor/menu/note/batch/batch_apply_leaf with storage rhythm_axe:prop
execute if score #bidx editor < #btotal editor run data remove storage rhythm_axe:prop idx
scoreboard players add #bidx editor 1
execute if score #bidx editor < #btotal editor run function rhythm_axe:editor/menu/note/batch/batch_apply_drive
