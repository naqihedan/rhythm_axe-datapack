# 单个音符：读字段 → 算出生/结束虚拟时刻 → 存活判定 → 分支
# 存活（playhead ∈ [出生, time+duration+1]）→ spawn_go_（生成+递归）
# 未出生 / 已消失 → spawn_next_（只递归）
#arg: cursor, note_idx
# 读取音符字段
$execute store result score #n_time editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(note_idx)].time
$execute store result score #n_type editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(note_idx)].type
$execute store result score #n_color editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(note_idx)].color
# note_base_life（缺省 32）
scoreboard players set #n_lt editor 32
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(note_idx)].note_base_life run execute store result score #n_lt editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(note_idx)].note_base_life
# duration（缺省默认：混凝土 1 / 玻璃 3 / 其余 0）
scoreboard players set #n_dur editor 0
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(note_idx)].duration run execute store result score #n_dur editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(note_idx)].duration
$execute if score #n_type editor matches 3 unless data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(note_idx)].duration run scoreboard players set #n_dur editor 1
$execute if score #n_type editor matches 4 unless data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(note_idx)].duration run scoreboard players set #n_dur editor 3
# 出生虚拟时刻：ignore_note_speed=1 → time - note_base_life；否则 time - note_base_life×16/note_speed
# ★ 2026-09-04 修复：按字段【值】判断而非【存在性】——字段存在但为 0b(false) 也应随流速缩放（此前"存在即忽略"，慢流速变快）
scoreboard players set #ig_on editor 0
$execute store result score #ig_on editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(note_idx)].ignore_note_speed
scoreboard players operation #n_birth editor = #n_time editor
execute if score #ig_on editor matches 1 run scoreboard players operation #n_birth editor -= #n_lt editor
scoreboard players operation #tmp_vis editor = #n_lt editor
scoreboard players operation #tmp_vis editor *= 16 const
scoreboard players operation #tmp_vis editor /= note_speed options
execute if score #ig_on editor matches 0 run scoreboard players operation #n_birth editor -= #tmp_vis editor
# 结束虚拟时刻（判定发光那一刻的下一刻出窗）：普通 = time；玻璃 = time+dur×16/流速+1（静默，随流速缩放）；混凝土 = time+dur（但音符只活跃到 time+dur-1，长度=dur）
scoreboard players operation #n_end editor = #n_time editor
execute if score #n_type editor matches 3 run scoreboard players operation #n_end editor += #n_dur editor
execute if score #n_type editor matches 3 run scoreboard players remove #n_end editor 1
# 玻璃穿过后段时长随流速缩放（ignore 除外；与游玩 note_glass_dur 一致）
scoreboard players operation #glass_end editor = #n_dur editor
execute if score #n_type editor matches 4 if score #ig_on editor matches 0 run scoreboard players operation #glass_end editor *= 16 const
execute if score #n_type editor matches 4 if score #ig_on editor matches 0 run scoreboard players operation #glass_end editor /= note_speed options
execute if score #n_type editor matches 4 run scoreboard players operation #n_end editor += #glass_end editor
execute if score #n_type editor matches 4 run scoreboard players add #n_end editor 1
# 进度 prog（×1000）：出生 0 → 判定 1000（clamp；分母<=0 视为已到判定）
scoreboard players operation #prog editor = #playhead editor
scoreboard players operation #prog editor -= #n_birth editor
scoreboard players operation #prog editor *= 1000 const
scoreboard players operation #den editor = #n_time editor
scoreboard players operation #den editor -= #n_birth editor
execute if score #den editor matches 1.. run scoreboard players operation #prog editor /= #den editor
execute if score #den editor matches ..0 run scoreboard players set #prog editor 1000
execute if score #prog editor matches ..0 run scoreboard players set #prog editor 0
execute if score #prog editor matches 1001.. run scoreboard players set #prog editor 1000
# 存活判定分支（三支互斥，避免重复递归）
execute if score #playhead editor >= #n_birth editor if score #playhead editor <= #n_end editor run function rhythm_axe:editor/visual/spawn_go_ with storage rhythm_axe:prop
# 未出生：记录第一个未出生 idx 到 #vis_next（播放游标起点，仅首次用哨兵）再继续
execute if score #playhead editor < #n_birth editor run function rhythm_axe:editor/visual/spawn_skip_ with storage rhythm_axe:prop
execute if score #playhead editor > #n_end editor run function rhythm_axe:editor/visual/spawn_next_ with storage rhythm_axe:prop
# 对【所有】音符（无论是否在窗口）维护前一个有效 0/1/2 指针：供下一个音符生成引导线快照用，不依赖其实体存活
$execute if score #n_type editor matches 0..2 run execute store result score #guide_last_id editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(note_idx)].id
$execute if score #n_type editor matches 0..2 run execute store result score #guide_last_px editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(note_idx)].position[0] 1000
$execute if score #n_type editor matches 0..2 run execute store result score #guide_last_py editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(note_idx)].position[1] 1000
$execute if score #n_type editor matches 0..2 run execute store result score #guide_last_pz editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(note_idx)].position[2] 1000
execute if score #n_type editor matches 0..2 run scoreboard players operation #guide_last_tp editor = #n_time editor
