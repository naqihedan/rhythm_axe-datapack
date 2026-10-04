#arg:cursor,index
# 时间轴翻转·收集：把该选中音符的判定时间**原地**改为 new = min + max − old（下界 0），
#   并把它的下标登记到 prop.move_idx（升序）。数组下标不变 ⇒ 顺序游标全程有效。
#   ★ 时间在收集阶段就写好：随后 editor/util/move_out_drive 移出时复制到的就是**新时间**，
#     move_in_drive 再按新时间二分插回 ⇒ 天然有序，**不需要任何排序**。
#   （2026-10-03 两次重构：先替掉「全扫 find + remove/重插」的 O(N×M)，再替掉「原地改 + order_repair」的 O(N²)）
$execute store result score #old_t editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].time
scoreboard players operation #new_t editor = #flip_min editor
scoreboard players operation #new_t editor += #flip_max editor
scoreboard players operation #new_t editor -= #old_t editor
execute if score #new_t editor matches ..-1 run scoreboard players set #new_t editor 0
$execute store result storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].time int 1 run scoreboard players get #new_t editor
$data modify storage rhythm_axe:prop move_idx append value $(index)
