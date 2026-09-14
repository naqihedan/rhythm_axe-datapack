#arg:cursor,i,i1
# 顺序修复宏叶子（只处理当前位置；不递归 / 不 return）
# i1 由驱动器传入 = i+1（宏参数不能做算术，故两个下标都作参数传）
# 结束条件：notes[i] 或 notes[i+1] 不存在（i 已是最后一个元素）
# 逆序判定用**严格大于**（等刻不交换）→ 稳定：等刻音符保持原有相对顺序
$execute unless data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(i)] run scoreboard players set #ord_done editor 1
$execute unless data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(i1)] run scoreboard players set #ord_done editor 1
$execute if score #ord_done editor matches 0 run execute store result score #ord_t0 editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(i)].time
$execute if score #ord_done editor matches 0 run execute store result score #ord_t1 editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(i1)].time
# 逆序：time[i] > time[i+1] → 相邻交换（prop.ord_tmp 中转）→ 回退一格（i-1，钳到 0）
$execute if score #ord_done editor matches 0 if score #ord_t0 editor > #ord_t1 editor run data modify storage rhythm_axe:prop ord_tmp set from storage rhythm_axe:maps.editor history[$(cursor)].notes[$(i)]
$execute if score #ord_done editor matches 0 if score #ord_t0 editor > #ord_t1 editor run data modify storage rhythm_axe:maps.editor history[$(cursor)].notes[$(i)] set from storage rhythm_axe:maps.editor history[$(cursor)].notes[$(i1)]
$execute if score #ord_done editor matches 0 if score #ord_t0 editor > #ord_t1 editor run data modify storage rhythm_axe:maps.editor history[$(cursor)].notes[$(i1)] set from storage rhythm_axe:prop ord_tmp
execute if score #ord_done editor matches 0 if score #ord_t0 editor > #ord_t1 editor run data remove storage rhythm_axe:prop ord_tmp
execute if score #ord_done editor matches 0 if score #ord_t0 editor > #ord_t1 editor run scoreboard players add #ord_swaps editor 1
$execute if score #ord_done editor matches 0 if score #ord_t0 editor > #ord_t1 editor run scoreboard players set #ord_next editor $(i)
execute if score #ord_done editor matches 0 if score #ord_t0 editor > #ord_t1 editor if score #ord_next editor matches 1.. run scoreboard players remove #ord_next editor 1
# 已有序：前进一格
$execute if score #ord_done editor matches 0 unless score #ord_t0 editor > #ord_t1 editor run scoreboard players set #ord_next editor $(i)
execute if score #ord_done editor matches 0 unless score #ord_t0 editor > #ord_t1 editor run scoreboard players add #ord_next editor 1
