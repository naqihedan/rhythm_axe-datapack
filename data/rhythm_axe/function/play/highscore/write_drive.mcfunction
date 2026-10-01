# 逐人写回驱动器（普通函数，递归；宏只做叶子 —— 同 note_find_alive_advance 的写法）
execute store result storage rhythm_axe:prop i int 1 run scoreboard players get #hs_i play_state
function rhythm_axe:play/highscore/write_leaf with storage rhythm_axe:prop
scoreboard players add #hs_i play_state 1
execute if score #hs_i play_state < #hs_n play_state run function rhythm_axe:play/highscore/write_drive
