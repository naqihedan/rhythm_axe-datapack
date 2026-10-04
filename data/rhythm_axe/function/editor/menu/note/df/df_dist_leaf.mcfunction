#arg: cursor, idx, mark
# 分配宏叶子：命中「参与分布」的音符 → 交给 df_dist_one 算这一颗，并把它记进 move_idx
#   $(mark) = 参与判据（宏注入路径片段）：selected = 普通分布 / df_dist_mark = 填充分布（新生成 + 头尾）
#   时间单位序号推进规则（prop.group 存在）：只有「换了一刻」的命中音符才 +1 ⇒ 同刻成员共用同一个 i
$scoreboard players set #dd_len editor $(idx)
execute if score #dd_len editor matches 0 run scoreboard players set #dd_tot editor 0
$execute if score #dd_len editor matches 0 run execute store result score #dd_tot editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(idx)].$(mark) run execute store result storage rhythm_axe:prop cur int 1 run scoreboard players get #dd_len editor
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(idx)].$(mark) run execute store result score #dd_t editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(idx)].time
execute if data storage rhythm_axe:prop group if score #dd_t editor > #dd_prev_t editor run scoreboard players add #dd_i editor 1
execute if data storage rhythm_axe:prop group if score #dd_t editor > #dd_prev_t editor run scoreboard players operation #dd_prev_t editor = #dd_t editor
$execute unless data storage rhythm_axe:prop group if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(idx)].$(mark) run scoreboard players add #dd_i editor 1
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(idx)].$(mark) run execute store result storage rhythm_axe:prop i int 1 run scoreboard players get #dd_i editor
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(idx)].$(mark) run execute store result storage rhythm_axe:prop i2 int 1 run scoreboard players get #dd_i2 editor
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(idx)].$(mark) run function rhythm_axe:editor/menu/note/df/df_dist_one with storage rhythm_axe:prop
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(idx)].$(mark) run data modify storage rhythm_axe:prop move_idx append from storage rhythm_axe:prop cur
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(idx)].$(mark) run scoreboard players add #dd_i2 editor 1
scoreboard players add #dd_len editor 1
execute if score #dd_len editor < #dd_tot editor run execute store result storage rhythm_axe:prop idx int 1 run scoreboard players get #dd_len editor
execute if score #dd_len editor < #dd_tot editor run function rhythm_axe:editor/menu/note/df/df_dist_leaf with storage rhythm_axe:prop
