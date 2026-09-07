# 遍历驱动器（普通函数）：处理当前 alive_idx 音符 → 递增 → 递归
# 前置：prop.cursor、prop.alive_idx（起始 0）、#alive_c；#note_total 由叶子顶部计算
function rhythm_axe:editor/menu/note/list/note_list_alive_seq_leaf with storage rhythm_axe:prop
execute store result score #idx editor run data get storage rhythm_axe:prop alive_idx
scoreboard players add #idx editor 1
execute store result storage rhythm_axe:prop alive_idx int 1 run scoreboard players get #idx editor
execute if score #idx editor < #note_total editor run function rhythm_axe:editor/menu/note/list/note_list_alive_seq_drive
