#arg: cursor, idx
# 扫描宏叶子：命中「选中」的音符时，按 prop 开关填端点
#   首个命中 → 填「起」（w_ta 时间 / w_sa 位置）
#   每次命中 → 覆盖「止」（w_tb 时间 / w_sb 位置）⇒ 最后一次 = 最晚
# #df_n = notes 长度（只在 idx=0 读一次，避免每轮把整表序列化）

$scoreboard players set #df_len editor $(idx)
execute if score #df_len editor matches 0 run scoreboard players set #df_n editor 0
$execute if score #df_len editor matches 0 run execute store result score #df_n editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes

# ── 首个命中：填「起」 ──
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(idx)].selected unless data storage rhythm_axe:prop got_first if data storage rhythm_axe:prop w_ta run data modify storage rhythm_axe:maps.editor editing.df.t_a set from storage rhythm_axe:maps.editor history[$(cursor)].notes[$(idx)].time
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(idx)].selected unless data storage rhythm_axe:prop got_first if data storage rhythm_axe:prop w_sa run execute store result score #df_v editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(idx)].position[0] 100
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(idx)].selected unless data storage rhythm_axe:prop got_first if data storage rhythm_axe:prop w_sa run execute store result storage rhythm_axe:maps.editor editing.df.s_a_fp[0] int 1 run scoreboard players get #df_v editor
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(idx)].selected unless data storage rhythm_axe:prop got_first if data storage rhythm_axe:prop w_sa run execute store result score #df_v editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(idx)].position[1] 100
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(idx)].selected unless data storage rhythm_axe:prop got_first if data storage rhythm_axe:prop w_sa run execute store result storage rhythm_axe:maps.editor editing.df.s_a_fp[1] int 1 run scoreboard players get #df_v editor
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(idx)].selected unless data storage rhythm_axe:prop got_first if data storage rhythm_axe:prop w_sa run execute store result score #df_v editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(idx)].position[2] 100
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(idx)].selected unless data storage rhythm_axe:prop got_first if data storage rhythm_axe:prop w_sa run execute store result storage rhythm_axe:maps.editor editing.df.s_a_fp[2] int 1 run scoreboard players get #df_v editor
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(idx)].selected run data modify storage rhythm_axe:prop got_first set value 1b

# ── 每次命中：覆盖「止」 ──
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(idx)].selected if data storage rhythm_axe:prop w_tb run data modify storage rhythm_axe:maps.editor editing.df.t_b set from storage rhythm_axe:maps.editor history[$(cursor)].notes[$(idx)].time
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(idx)].selected if data storage rhythm_axe:prop w_sb run execute store result score #df_v editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(idx)].position[0] 100
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(idx)].selected if data storage rhythm_axe:prop w_sb run execute store result storage rhythm_axe:maps.editor editing.df.s_b_fp[0] int 1 run scoreboard players get #df_v editor
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(idx)].selected if data storage rhythm_axe:prop w_sb run execute store result score #df_v editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(idx)].position[1] 100
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(idx)].selected if data storage rhythm_axe:prop w_sb run execute store result storage rhythm_axe:maps.editor editing.df.s_b_fp[1] int 1 run scoreboard players get #df_v editor
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(idx)].selected if data storage rhythm_axe:prop w_sb run execute store result score #df_v editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(idx)].position[2] 100
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(idx)].selected if data storage rhythm_axe:prop w_sb run execute store result storage rhythm_axe:maps.editor editing.df.s_b_fp[2] int 1 run scoreboard players get #df_v editor

# ── 下一个（#df_len 进入本轮时 = 本轮 idx，+1 即下一下标）──
scoreboard players add #df_len editor 1
execute if score #df_len editor < #df_n editor run execute store result storage rhythm_axe:prop idx int 1 run scoreboard players get #df_len editor
execute if score #df_len editor < #df_n editor run function rhythm_axe:editor/menu/note/df/df_scan_leaf with storage rhythm_axe:prop
