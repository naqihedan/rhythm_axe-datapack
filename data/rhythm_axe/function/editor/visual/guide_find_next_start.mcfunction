# 向后查找「下一个普通音符 B」——替代原来的全表预扫描 guide_prescan_
# ★ 2026-09-14 性能重构：原 guide_prescan_ 要为**全部** 976 个音符读 7 个字段（33 条命令/17 宏行），
#   但引导线只在「存活的 + 开启 following_point 的」音符上生成（通常只有几个到几十个）→ 99% 是白做。
#   现在改为：生成某个音符的引导线时，从它后面**现场**找最近的普通音符（一般只走 1~3 步）。
# 前置：storage rhythm_axe:prop.cursor；#gnx_from = 当前音符下标
# 产出：#gnx_found(0/1)、#gnx_id、#gnx_time、#gnx_sx/sy/sz（B 出生点 = position + start_pos，×100）
scoreboard players set #gnx_found editor 0
scoreboard players set #gnx_end editor 0
scoreboard players operation #gnx_walk editor = #gnx_from editor
scoreboard players add #gnx_walk editor 1
function rhythm_axe:editor/visual/guide_find_next_drive
