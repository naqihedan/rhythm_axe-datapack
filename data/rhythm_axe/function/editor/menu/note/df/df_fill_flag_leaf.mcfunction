#arg: cursor, ff_i
# 收尾叶子：处理 notes[ff_i] 这一颗 —— 按 dfsel 决定它的选中状态，并清掉 df_new 标记
#   #ff_keep = 1 表示这颗要进新选区：本次新生成的（df_new）或站在起点/终点上的头尾音符
#   #ff_sel / #ff_ta / #ff_tb 由 df_fill_flag 预先读好（每轮复用，别在这里改）
scoreboard players set #ff_t editor 0
$execute store result score #ff_t editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(ff_i)].time
scoreboard players set #ff_keep editor 0
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(ff_i)].df_new run scoreboard players set #ff_keep editor 1
execute if score #ff_t editor = #ff_ta editor run scoreboard players set #ff_keep editor 1
execute if score #ff_t editor = #ff_tb editor run scoreboard players set #ff_keep editor 1

# ── dfsel = 1：重建选区（保留 keep 的，取消其余的原选中）──
$execute if score #ff_sel editor matches 1 if score #ff_keep editor matches 1 run data modify storage rhythm_axe:maps.editor history[$(cursor)].notes[$(ff_i)].selected set value 1b
$execute if score #ff_sel editor matches 1 if score #ff_keep editor matches 1 run data modify storage rhythm_axe:maps.editor selection append from storage rhythm_axe:maps.editor history[$(cursor)].notes[$(ff_i)].id
$execute if score #ff_sel editor matches 1 if score #ff_keep editor matches 0 run data remove storage rhythm_axe:maps.editor history[$(cursor)].notes[$(ff_i)].selected

# ── dfsel = 0：只把新生成的取消选中（选区操作前后完全不变）──
$execute if score #ff_sel editor matches 0 if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(ff_i)].df_new run data remove storage rhythm_axe:maps.editor history[$(cursor)].notes[$(ff_i)].selected

# ── 清 df_new ──
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(ff_i)].df_new run data remove storage rhythm_axe:maps.editor history[$(cursor)].notes[$(ff_i)].df_new

# ── 清 df_dist_mark（填充分布阶段的参与标记）──
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(ff_i)].df_dist_mark run data remove storage rhythm_axe:maps.editor history[$(cursor)].notes[$(ff_i)].df_dist_mark

# ── 下一个（#ff_len 进入本轮时 = 本轮下标，+1 即下一个）──
$scoreboard players set #ff_len editor $(ff_i)
scoreboard players add #ff_len editor 1
execute if score #ff_len editor < #ff_max editor run execute store result storage rhythm_axe:prop ff_i int 1 run scoreboard players get #ff_len editor
execute if score #ff_len editor < #ff_max editor run function rhythm_axe:editor/menu/note/df/df_fill_flag_leaf with storage rhythm_axe:prop
