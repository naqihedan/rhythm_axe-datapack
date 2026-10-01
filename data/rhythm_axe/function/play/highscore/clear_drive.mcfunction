# 清榜驱动器（普通函数，递归；宏只做叶子）
execute store result storage rhythm_axe:prop i int 1 run scoreboard players get #rh_i editor
function rhythm_axe:play/highscore/clear_leaf with storage rhythm_axe:prop
scoreboard players add #rh_i editor 1
execute if score #rh_i editor < #rh_n editor run function rhythm_axe:play/highscore/clear_drive
