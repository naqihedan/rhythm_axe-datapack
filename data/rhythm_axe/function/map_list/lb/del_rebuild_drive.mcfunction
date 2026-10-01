# 重建名单的驱动器（普通函数，递归；宏只做叶子 —— 同 highscore/write_drive 的写法）
execute store result storage rhythm_axe:prop i int 1 run scoreboard players get #lb_ri menu
function rhythm_axe:map_list/lb/del_rebuild_leaf with storage rhythm_axe:prop
scoreboard players add #lb_ri menu 1
execute if score #lb_ri menu < #lb_rn menu run function rhythm_axe:map_list/lb/del_rebuild_drive
