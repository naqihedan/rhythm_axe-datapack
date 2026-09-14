# [已废弃 2026-09-14 性能重构] 无调用者（guide_state_find_drive 已退役）。保留仅为便于回滚。
#arg:cursor,i
# 引导线状态复原宏叶子：探测 notes[$(i)]，若是普通音符（0..2）→ 记 #gn_last=$(i)、#gn_fp=其 following_point(缺省0)、#gn_found=1
# 供 refresh_note_added 从插入点继续做预扫描（预扫描的 #gn_last/#gn_fp 语义＝「扫到该下标时的状态」）
$execute store success score #gn_ex editor run execute store result score #gn_ty editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(i)].type
scoreboard players set #gn_fp editor 0
$execute if score #gn_ex editor matches 1 if score #gn_ty editor matches 0..2 if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(i)].following_point run execute store result score #gn_fp editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(i)].following_point
$execute if score #gn_ex editor matches 1 if score #gn_ty editor matches 0..2 run scoreboard players set #gn_last editor $(i)
execute if score #gn_ex editor matches 1 if score #gn_ty editor matches 0..2 run scoreboard players set #gn_found editor 1
