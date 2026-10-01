# 改名搬移驱动器（普通函数，递归；宏只做叶子）
execute store result storage rhythm_axe:prop i int 1 run scoreboard players get #hr_i play_state
function rhythm_axe:play/highscore/rename_leaf with storage rhythm_axe:prop
scoreboard players add #hr_i play_state 1
execute if score #hr_i play_state < #hr_n play_state run function rhythm_axe:play/highscore/rename_drive
