# [已废弃 2026-09-14 性能重构] 原为 refresh_note_added 服务（从插入点往前找上一个普通音符以继续预扫描）。
#   预扫描已取消 → 本函数无调用者。保留仅为便于回滚；新代码请勿调用。
# 引导线状态复原驱动器（普通函数，可递归）：从 #gn_walk 往前找最近一个普通音符（0..2）
# 找到 → #gn_last=该下标、#gn_fp=其 following_point（由叶子写）、#gn_found=1
# 走到 -1 → #gn_last=-1、#gn_fp=0（前面没有普通音符）
# 前置：prop.cursor、#gn_walk（起始 = 插入点-1）、#gn_found=0
execute if score #gn_found editor matches 1 run return 0
execute if score #gn_walk editor matches ..-1 run scoreboard players set #gn_last editor -1
execute if score #gn_walk editor matches ..-1 run scoreboard players set #gn_fp editor 0
execute if score #gn_walk editor matches ..-1 run scoreboard players set #gn_found editor 1
execute if score #gn_found editor matches 1 run return 0
execute store result storage rhythm_axe:prop i int 1 run scoreboard players get #gn_walk editor
function rhythm_axe:editor/visual/guide_state_find_leaf with storage rhythm_axe:prop
execute if score #gn_found editor matches 1 run return 0
scoreboard players remove #gn_walk editor 1
function rhythm_axe:editor/visual/guide_state_find_drive
