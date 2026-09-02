# 为单个开启 following_point 音符 A 生成连向其紧邻下一个音符 B 的引导线实体
# 引导线归属 A（note_guide_a=A、note_guide_b=B）；A 未出生时由 guide_tick 隐藏，A 出生后显示
# B 是否开启不影响生成；依赖：guide_prescan_ 已写入 guide_prev.notes[note_idx].next_*（紧邻下一个音符）
#arg: cursor, note_idx
# 读当前音符 A 的字段
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(note_idx)].id run execute store result score #gs_id editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(note_idx)].id
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(note_idx)].type run execute store result score #gs_type editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(note_idx)].type
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(note_idx)].time run execute store result score #gs_time editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(note_idx)].time
scoreboard players set #gs_fp editor 0
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(note_idx)].following_point run execute store result score #gs_fp editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(note_idx)].following_point
# A 判定位置（×100，m>=0 时 A 端快照）
scoreboard players set #gs_ax editor 0
scoreboard players set #gs_ay editor 0
scoreboard players set #gs_az editor 0
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(note_idx)].position[0] run execute store result score #gs_ax editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(note_idx)].position[0] 100
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(note_idx)].position[1] run execute store result score #gs_ay editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(note_idx)].position[1] 100
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(note_idx)].position[2] run execute store result score #gs_az editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(note_idx)].position[2] 100
# 生成条件：type 0/1/2 且 following_point 且 next 存在
data remove storage rhythm_axe:prop guide_flag
$execute if score #gs_type editor matches 0..2 if score #gs_fp editor matches 1 if data storage rhythm_axe:guide_prev notes[$(note_idx)].next_id run execute store result score #gn_id editor run data get storage rhythm_axe:guide_prev notes[$(note_idx)].next_id
execute if score #gs_type editor matches 0..2 if score #gs_fp editor matches 1 if score #gn_id editor matches 0.. unless score #gn_id editor = #gs_id editor run data modify storage rhythm_axe:prop guide_flag set value 1b
execute unless score #gs_type editor matches 0..2 run data remove storage rhythm_axe:prop guide_flag
# B（下一个）出生点/判定时刻
$execute if data storage rhythm_axe:prop guide_flag run execute store result score #gs_tp editor run data get storage rhythm_axe:guide_prev notes[$(note_idx)].next_time
# ★ 防御：B 判定时刻 <=0（prescan 越界残留）→ 不生成（否则产生 n<0 的幽灵引导线；同刻 next_time=A.time>0 不受影响）
execute if data storage rhythm_axe:prop guide_flag if score #gs_tp editor matches ..0 run data remove storage rhythm_axe:prop guide_flag
$execute if data storage rhythm_axe:prop guide_flag run execute store result score #gs_sx editor run data get storage rhythm_axe:guide_prev notes[$(note_idx)].next_sx
$execute if data storage rhythm_axe:prop guide_flag run execute store result score #gs_sy editor run data get storage rhythm_axe:guide_prev notes[$(note_idx)].next_sy
$execute if data storage rhythm_axe:prop guide_flag run execute store result score #gs_sz editor run data get storage rhythm_axe:guide_prev notes[$(note_idx)].next_sz
# n = B 判定时刻 - A 判定时刻
execute if data storage rhythm_axe:prop guide_flag run scoreboard players operation #gs_n editor = #gs_tp editor
execute if data storage rhythm_axe:prop guide_flag run scoreboard players operation #gs_n editor -= #gs_time editor
# 存 prop 调 guide_spawn_（nid=A、guide_prev=B、guide_tp=A 判定时刻、guide_ax/ay/az=A 判定位置、guide_sx/sy/sz=B 出生点）
execute if data storage rhythm_axe:prop guide_flag run execute store result storage rhythm_axe:prop nid int 1 run scoreboard players get #gs_id editor
execute if data storage rhythm_axe:prop guide_flag run execute store result storage rhythm_axe:prop guide_prev int 1 run scoreboard players get #gn_id editor
execute if data storage rhythm_axe:prop guide_flag run execute store result storage rhythm_axe:prop guide_tp int 1 run scoreboard players get #gs_time editor
execute if data storage rhythm_axe:prop guide_flag run execute store result storage rhythm_axe:prop guide_n int 1 run scoreboard players get #gs_n editor
execute if data storage rhythm_axe:prop guide_flag run execute store result storage rhythm_axe:prop guide_ax int 1 run scoreboard players get #gs_ax editor
execute if data storage rhythm_axe:prop guide_flag run execute store result storage rhythm_axe:prop guide_ay int 1 run scoreboard players get #gs_ay editor
execute if data storage rhythm_axe:prop guide_flag run execute store result storage rhythm_axe:prop guide_az int 1 run scoreboard players get #gs_az editor
execute if data storage rhythm_axe:prop guide_flag run execute store result storage rhythm_axe:prop guide_sx int 1 run scoreboard players get #gs_sx editor
execute if data storage rhythm_axe:prop guide_flag run execute store result storage rhythm_axe:prop guide_sy int 1 run scoreboard players get #gs_sy editor
execute if data storage rhythm_axe:prop guide_flag run execute store result storage rhythm_axe:prop guide_sz int 1 run scoreboard players get #gs_sz editor
execute if data storage rhythm_axe:prop guide_flag run function rhythm_axe:editor/visual/guide_spawn_ with storage rhythm_axe:prop
data remove storage rhythm_axe:prop guide_flag
