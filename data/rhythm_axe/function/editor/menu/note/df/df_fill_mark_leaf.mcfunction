#arg: cursor, dm_i
# 打标叶子：notes[$(dm_i)] 若是「本次新生成」或「站在起点/终点上」→ 打 df_dist_mark
#   #dm_ta / #dm_tb / #dm_max 由 df_fill_mark 预先读好（本轮复用，别在这里改）
scoreboard players set #dm_t editor 0
$execute store result score #dm_t editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(dm_i)].time
scoreboard players set #dm_keep editor 0
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(dm_i)].df_new run scoreboard players set #dm_keep editor 1
execute if score #dm_t editor = #dm_ta editor run scoreboard players set #dm_keep editor 1
execute if score #dm_t editor = #dm_tb editor run scoreboard players set #dm_keep editor 1
$execute if score #dm_keep editor matches 1 run data modify storage rhythm_axe:maps.editor history[$(cursor)].notes[$(dm_i)].df_dist_mark set value 1b
$scoreboard players set #dm_len editor $(dm_i)
scoreboard players add #dm_len editor 1
execute if score #dm_len editor < #dm_max editor run execute store result storage rhythm_axe:prop dm_i int 1 run scoreboard players get #dm_len editor
execute if score #dm_len editor < #dm_max editor run function rhythm_axe:editor/menu/note/df/df_fill_mark_leaf with storage rhythm_axe:prop
