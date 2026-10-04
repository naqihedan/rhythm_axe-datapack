#arg: cursor, idx, mark
# 计数宏叶子（只数「参与分布」的音符）：
#   $(mark) = 参与判据（宏注入路径片段）：selected = 普通分布 / df_dist_mark = 填充分布（新生成 + 头尾）
#   #dc_n2 = 颗数（每颗 +1）；#dc_n = 时间单位数（#dc_prev_t 记录上一刻，换刻才 +1）
#   ⚠️ 用 #dc_prev_t 比较而不是「重置 #dc_t」：非命中音符不更新 #dc_t，#dc_t > #dc_prev_t 自然为假
$scoreboard players set #dc_len editor $(idx)
execute if score #dc_len editor matches 0 run scoreboard players set #dc_tot editor 0
$execute if score #dc_len editor matches 0 run execute store result score #dc_tot editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(idx)].$(mark) run execute store result score #dc_t editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(idx)].time
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(idx)].$(mark) run scoreboard players add #dc_n2 editor 1
$execute unless data storage rhythm_axe:prop group if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(idx)].$(mark) run scoreboard players add #dc_n editor 1
execute if data storage rhythm_axe:prop group if score #dc_t editor > #dc_prev_t editor run scoreboard players add #dc_n editor 1
execute if data storage rhythm_axe:prop group if score #dc_t editor > #dc_prev_t editor run scoreboard players operation #dc_prev_t editor = #dc_t editor
scoreboard players add #dc_len editor 1
execute if score #dc_len editor < #dc_tot editor run execute store result storage rhythm_axe:prop idx int 1 run scoreboard players get #dc_len editor
execute if score #dc_len editor < #dc_tot editor run function rhythm_axe:editor/menu/note/df/df_dist_count_leaf with storage rhythm_axe:prop
