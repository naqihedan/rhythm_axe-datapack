# [已废弃 2026-09-14 性能重构] 「遍历推进」已改由普通驱动器 spawn_drive 负责（宏叶子单步，避免幽灵重跑）。
#   无调用者；保留仅为便于回滚。
# 推进到下一个音符并继续遍历（宏参数 note_idx；链终止由 spawn_note_ 的 if data 保证）
# ★ 不再在此生成引导线：引导线只由 spawn_go_（存活音符）生成；已消失音符的引导线由先前生成的实体经 guide_tick 继续显示
#arg: note_idx
scoreboard players add #vis_idx editor 1
execute store result storage rhythm_axe:prop note_idx int 1 run scoreboard players get #vis_idx editor
function rhythm_axe:editor/visual/spawn_note_ with storage rhythm_axe:prop
