# 播放新出生单个音符：读字段算出生/结束/进度
# 已到出生（playhead >= birth）→ tick_birth_go_（生成+继续）；已消失 → tick_birth_next_（跳过推进）；未出生 → 停
#arg: cursor, note_idx
$execute store result score #n_time editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(note_idx)].time
$execute store result score #n_type editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(note_idx)].type
$execute store result score #n_color editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(note_idx)].color
scoreboard players set #n_lt editor 32
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(note_idx)].note_base_life run execute store result score #n_lt editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(note_idx)].note_base_life
scoreboard players set #n_dur editor 0
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(note_idx)].duration run execute store result score #n_dur editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(note_idx)].duration
$execute if score #n_type editor matches 3 unless data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(note_idx)].duration run scoreboard players set #n_dur editor 1
$execute if score #n_type editor matches 4 unless data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(note_idx)].duration run scoreboard players set #n_dur editor 3
# 出生虚拟时刻（同 spawn_one_）
scoreboard players operation #n_birth editor = #n_time editor
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(note_idx)].ignore_note_speed run scoreboard players operation #n_birth editor -= #n_lt editor
scoreboard players operation #tmp_vis editor = #n_lt editor
scoreboard players operation #tmp_vis editor *= 16 const
scoreboard players operation #tmp_vis editor /= note_speed options
$execute unless data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(note_idx)].ignore_note_speed run scoreboard players operation #n_birth editor -= #tmp_vis editor
# 结束虚拟时刻（判定发光那一刻的下一刻出窗）：普通 = time；玻璃 = time+dur×16/流速+1（静默，随流速缩放）；混凝土 = time+dur（但音符只活跃到 time+dur-1，长度=dur）
scoreboard players operation #n_end editor = #n_time editor
execute if score #n_type editor matches 3 run scoreboard players operation #n_end editor += #n_dur editor
execute if score #n_type editor matches 3 run scoreboard players remove #n_end editor 1
# 玻璃穿过后段时长随流速缩放（ignore 除外；与游玩 note_glass_dur 一致）
scoreboard players operation #glass_end editor = #n_dur editor
$execute if score #n_type editor matches 4 unless data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(note_idx)].ignore_note_speed run scoreboard players operation #glass_end editor *= 16 const
$execute if score #n_type editor matches 4 unless data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(note_idx)].ignore_note_speed run scoreboard players operation #glass_end editor /= note_speed options
execute if score #n_type editor matches 4 run scoreboard players operation #n_end editor += #glass_end editor
execute if score #n_type editor matches 4 run scoreboard players add #n_end editor 1
# density（混凝土判定密度；缺省 8）
scoreboard players set #n_density editor 8
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(note_idx)].density run execute store result score #n_density editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(note_idx)].density
# 进度（build_/summon_ 定位用）
scoreboard players operation #prog editor = #playhead editor
scoreboard players operation #prog editor -= #n_birth editor
scoreboard players operation #prog editor *= 1000 const
scoreboard players operation #den editor = #n_time editor
scoreboard players operation #den editor -= #n_birth editor
execute if score #den editor matches 1.. run scoreboard players operation #prog editor /= #den editor
execute if score #den editor matches ..0 run scoreboard players set #prog editor 1000
execute if score #prog editor matches ..0 run scoreboard players set #prog editor 0
execute if score #prog editor matches 1001.. run scoreboard players set #prog editor 1000
# 分支：存活→生成+继续；已消失→跳过推进；未出生→停（游标留在当前 idx）
execute if score #playhead editor >= #n_birth editor if score #playhead editor <= #n_end editor run function rhythm_axe:editor/visual/tick_birth_go_ with storage rhythm_axe:prop
execute if score #playhead editor > #n_end editor run function rhythm_axe:editor/visual/tick_birth_next_ with storage rhythm_axe:prop
