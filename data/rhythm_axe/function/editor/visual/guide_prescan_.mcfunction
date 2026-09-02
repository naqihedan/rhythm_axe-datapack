# 预扫描宏叶子：为每个开启 following_point 音符记录其"下一个普通音符 next"（id/出生点/判定时刻）
# 引导线由 A（开启音符）指向 B（A 之后的第一个普通音符 0/1/2）；B 是否开启 fp 不影响生成
# 混凝土/玻璃(3/4)不作为 next 目标也不更新 prev → A 连向其后第一个普通音符
# 维护：#gn_last（上一个普通音符下标，宏参数传递用作 notes 下标）+ #gn_fp（上一个普通音符是否开启，scoreboard 全局）
#arg: cursor, scan_idx, gn_last
# 当前音符 type（防越界：若该音符不存在则整段不触发）
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(scan_idx)].type run execute store result score #ptype editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(scan_idx)].type
# 占位：先为当前音符 append 一个空 compound，保证 notes[scan_idx] 存在。
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(scan_idx)].type run data modify storage rhythm_axe:guide_prev notes append value {}
# 读当前音符 following_point（缺省 0 = 关闭）/id/判定时刻/出生点(×100)
scoreboard players set #p_fp editor 0
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(scan_idx)].following_point run execute store result score #p_fp editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(scan_idx)].following_point
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(scan_idx)].id run execute store result score #p_id editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(scan_idx)].id
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(scan_idx)].time run execute store result score #p_time editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(scan_idx)].time
scoreboard players set #p_sx editor 0
scoreboard players set #p_sy editor 0
scoreboard players set #p_sz editor 0
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(scan_idx)].start_pos[0] run execute store result score #p_sx editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(scan_idx)].start_pos[0] 100
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(scan_idx)].start_pos[1] run execute store result score #p_sy editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(scan_idx)].start_pos[1] 100
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(scan_idx)].start_pos[2] run execute store result score #p_sz editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(scan_idx)].start_pos[2] 100
# 出生位置 = 判定位置 + 起始位置（×100）：#p_sx/sy/sz 累加判定位置（position）
scoreboard players set #p_px editor 0
scoreboard players set #p_py editor 0
scoreboard players set #p_pz editor 0
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(scan_idx)].position[0] run execute store result score #p_px editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(scan_idx)].position[0] 100
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(scan_idx)].position[1] run execute store result score #p_py editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(scan_idx)].position[1] 100
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(scan_idx)].position[2] run execute store result score #p_pz editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(scan_idx)].position[2] 100
scoreboard players operation #p_sx editor += #p_px editor
scoreboard players operation #p_sy editor += #p_py editor
scoreboard players operation #p_sz editor += #p_pz editor
# 上一个普通音符开启（#gn_fp==1）→ 给其记 next = 当前；当前须为普通(0/1/2)，无需开启 fp（B 不要求 following_point）
# 用 scoreboard 全局 #gn_fp（防宏双参错位）；目标下标用宏 $(gn_last)
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(scan_idx)].type if score #ptype editor matches 0..2 if score #gn_fp editor matches 1 if score #gn_last editor matches 0.. run execute store result storage rhythm_axe:guide_prev notes[$(gn_last)].next_id int 1 run scoreboard players get #p_id editor
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(scan_idx)].type if score #ptype editor matches 0..2 if score #gn_fp editor matches 1 if score #gn_last editor matches 0.. run execute store result storage rhythm_axe:guide_prev notes[$(gn_last)].next_sx int 1 run scoreboard players get #p_sx editor
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(scan_idx)].type if score #ptype editor matches 0..2 if score #gn_fp editor matches 1 if score #gn_last editor matches 0.. run execute store result storage rhythm_axe:guide_prev notes[$(gn_last)].next_sy int 1 run scoreboard players get #p_sy editor
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(scan_idx)].type if score #ptype editor matches 0..2 if score #gn_fp editor matches 1 if score #gn_last editor matches 0.. run execute store result storage rhythm_axe:guide_prev notes[$(gn_last)].next_sz int 1 run scoreboard players get #p_sz editor
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(scan_idx)].type if score #ptype editor matches 0..2 if score #gn_fp editor matches 1 if score #gn_last editor matches 0.. run execute store result storage rhythm_axe:guide_prev notes[$(gn_last)].next_time int 1 run scoreboard players get #p_time editor
# 更新：#gn_last = 当前下标（仅当前为普通时）；#gn_fp = 当前是否开启（混凝土/玻璃不更新 → 跨过）
execute if score #ptype editor matches 0..2 run scoreboard players operation #gn_last editor = #scan_idx editor
execute if score #ptype editor matches 0..2 run scoreboard players set #gn_fp editor 0
execute if score #ptype editor matches 0..2 if score #p_fp editor matches 1 run scoreboard players set #gn_fp editor 1
# 递归下一个音符
scoreboard players add #scan_idx editor 1
execute store result storage rhythm_axe:prop scan_idx int 1 run scoreboard players get #scan_idx editor
execute store result storage rhythm_axe:prop gn_last int 1 run scoreboard players get #gn_last editor
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(scan_idx)].type run function rhythm_axe:editor/visual/guide_prescan_ with storage rhythm_axe:prop
