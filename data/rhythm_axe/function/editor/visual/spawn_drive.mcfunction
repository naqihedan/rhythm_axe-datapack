# 音符遍历驱动器（**普通函数**，可安全递归）——替代原先「宏函数互相递归」的 spawn_note_/spawn_one_/spawn_next_ 链
# ★ 2026-09-14：原链是纯宏递归，实测下标会多走约 1.47 倍（幽灵重跑），既浪费又可能让 #vis_idx 失真。
#   现在改成项目里既有惯例的「普通驱动器 + 宏叶子单步」：
#     驱动器（本文件）负责取下标 / 推进 / 终止；宏叶子 spawn_note_ 只处理当前这一个音符，不递归。
# 前置：#vis_idx=0、#vis_stop=0、storage rhythm_axe:prop.cursor
execute if score #vis_stop editor matches 1 run return 0
execute store result storage rhythm_axe:prop note_idx int 1 run scoreboard players get #vis_idx editor
function rhythm_axe:editor/visual/spawn_note_ with storage rhythm_axe:prop
execute if score #vis_stop editor matches 1 run return 0
scoreboard players add #vis_idx editor 1
function rhythm_axe:editor/visual/spawn_drive
