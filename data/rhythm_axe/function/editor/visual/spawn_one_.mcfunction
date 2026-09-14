# 单个音符：读字段 → 算出生/结束虚拟时刻 → 存活判定 → 分支
# 存活（playhead ∈ [出生, time+duration+1]）→ spawn_go_（生成+递归）
# 未出生 / 已消失 → spawn_next_（只递归）
#arg: cursor, note_idx
# ★ 2026-09-14：先把整个音符元素复制进 prop.note（本函数**唯一**的宏行），后续全部用非宏 data get。
#   原因：`function ... with storage` 每次调用都要**展开函数体内所有 $ 行**（不管是否执行到），
#   原来这里有 9 行宏 = 每个音符都要付 9 行宏展开；现在每个音符只需 1 行。
$data modify storage rhythm_axe:prop note set from storage rhythm_axe:maps.editor history[$(cursor)].notes[$(note_idx)]
# 读取音符字段（非宏命令，无展开成本）
execute store result score #n_time editor run data get storage rhythm_axe:prop note.time
execute store result score #n_type editor run data get storage rhythm_axe:prop note.type
# ★ 2026-09-14 快速①：已过判定时刻的普通音符（0..2）必然已消失（end = time）
#   refresh 要遍历全部音符，而同一时刻只存活几个到几十个 → 绝大多数音符走的就是这条路径：只需 2 次 data get
#   （推进由 spawn_drive 负责，这里直接 return 即可）
execute if score #n_time editor < #playhead editor if score #n_type editor matches 0..2 run return 0
# note_base_life（缺省 32）
scoreboard players set #n_lt editor 32
execute if data storage rhythm_axe:prop note.note_base_life run execute store result score #n_lt editor run data get storage rhythm_axe:prop note.note_base_life
# 出生虚拟时刻：ignore_note_speed=1 → time - note_base_life；否则 time - note_base_life×16/note_speed
# ★ 2026-09-04 修复：按字段【值】判断而非【存在性】——字段存在但为 0b(false) 也应随流速缩放（此前"存在即忽略"，慢流速变快）
scoreboard players set #ig_on editor 0
execute store result score #ig_on editor run data get storage rhythm_axe:prop note.ignore_note_speed
scoreboard players operation #n_birth editor = #n_time editor
execute if score #ig_on editor matches 1 run scoreboard players operation #n_birth editor -= #n_lt editor
scoreboard players operation #tmp_vis editor = #n_lt editor
scoreboard players operation #tmp_vis editor *= 16 const
scoreboard players operation #tmp_vis editor /= note_speed options
execute if score #ig_on editor matches 0 run scoreboard players operation #n_birth editor -= #tmp_vis editor
# ★ 2026-09-14 快速②：还没出生（birth > playhead）→ 记下播放游标后跳过，不读 color/duration、不算 end/prog
#   （原来调 spawn_skip_，现在直接把它的逻辑内联：哨兵 999999 保证只记首次）
execute if score #n_birth editor > #playhead editor if score #vis_next editor matches 999999 run scoreboard players operation #vis_next editor = #vis_idx editor
execute if score #n_birth editor > #playhead editor run return 0
# ---- 以下只有「窗口内（可能存活）」的音符才会走到：读剩余字段 + 算 end/prog ----
# duration（缺省默认：混凝土 1 / 玻璃 3 / 其余 0）
scoreboard players set #n_dur editor 0
execute if data storage rhythm_axe:prop note.duration run execute store result score #n_dur editor run data get storage rhythm_axe:prop note.duration
execute if score #n_type editor matches 3 unless data storage rhythm_axe:prop note.duration run scoreboard players set #n_dur editor 1
execute if score #n_type editor matches 4 unless data storage rhythm_axe:prop note.duration run scoreboard players set #n_dur editor 3
# 颜色（死亡时才用不着；此处只在窗口内读，省掉绝大多数无用读取）
execute store result score #n_color editor run data get storage rhythm_axe:prop note.color
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
# 存活判定分支：只有「窗口内」才生成实体（未出生/已消失都不用做事，推进由 spawn_drive 负责）
execute if score #playhead editor >= #n_birth editor if score #playhead editor <= #n_end editor run function rhythm_axe:editor/visual/spawn_go_ with storage rhythm_axe:prop
# ★ 2026-09-14：原「维护 #guide_last_*（id/坐标/时刻）」已删除 —— 全库无消费者（guide_build_for_ 改用
#   guide_find_next_* 现场查找），但它在**每个普通音符**上多花 4 次 data get（全表约 3900 次）。
