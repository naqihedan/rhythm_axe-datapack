# 锚点包围盒中心：遍历 selected 下标（普通函数驱动器，防宏递归幽灵）
# 前置：#ac_i（0 起）/ #ac_total（selection 长度）、prop.cursor、prop.anc_cursor、#ac_min*/#ac_max* 已初始化
execute if score #ac_i editor matches 1000000.. run return 0
execute if score #ac_i editor < #ac_total editor run execute store result storage rhythm_axe:prop idx int 1 run scoreboard players get #ac_i editor
execute if score #ac_i editor < #ac_total editor run function rhythm_axe:editor/menu/note/anchor/anchor_center_leaf with storage rhythm_axe:prop
execute if score #ac_i editor < #ac_total editor run data remove storage rhythm_axe:prop idx
scoreboard players add #ac_i editor 1
execute if score #ac_i editor < #ac_total editor run function rhythm_axe:editor/menu/note/anchor/anchor_center_drive
