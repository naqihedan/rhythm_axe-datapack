#arg:cursor,i
# 正向命中判定（notes 按 time 升序，且驱动器从「第一个 time ≥ min」的下标开始）：
#   本音符 time ≥ min ⇒ 只要 time ≤ max 就与区间相交 → 命中
#   time > max ⇒ 置 #ts_stop=1，驱动器立即停（后面的 time 只会更大，不可能命中）
# ★ 区间 min/max 只从驱动器算好的 #ts_min/#ts_max 分数读，**不进宏参数**：
#   否则每个 (i,min,max) 组合都会生成一份宏展开缓存（26.x 缓存随区间数无限增长，越点越慢）；
#   只用 (cursor,i) 作参数时与 sel_rebuild_judge 同参数空间，缓存可复用且有界
$execute store result score #ts_time editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(i)].time
scoreboard players set #ts_stop editor 0
execute if score #ts_time editor > #ts_max editor run scoreboard players set #ts_stop editor 1
execute if score #ts_stop editor matches 1 run return 0
scoreboard players set #ts_hit editor 1
execute if score #ts_hit editor matches 1 run execute store result storage rhythm_axe:prop idx int 1 run scoreboard players get #ts_i editor
$execute if score #ts_hit editor matches 1 run execute store result storage rhythm_axe:prop nid int 1 run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(i)].id
execute if score #ts_hit editor matches 1 run function rhythm_axe:editor/menu/note/selected/sel_select_one with storage rhythm_axe:prop
execute if score #ts_hit editor matches 1 run scoreboard players add #sel_count editor 1
execute if score #ts_hit editor matches 1 run function rhythm_axe:editor/tool/select/select_mark_glow with storage rhythm_axe:prop
execute if score #ts_hit editor matches 1 run function rhythm_axe:editor/tool/select/time_select_tag with storage rhythm_axe:prop
