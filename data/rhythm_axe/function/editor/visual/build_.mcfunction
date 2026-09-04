# 拆字段到 prop（宏参数）并调 summon_ 生成实体（生成骨架共用：全量刷新 spawn_go_ / 播放 tick_birth_go_）
# 前置：#n_lt / #n_dur / #prog（editor 计分板）已由调用方（spawn_one_ / tick_birth_one_）算好
# ★ 每个字段先设默认值再 if data 覆盖：旧谱面/手动音符可能缺字段，缺失会导致 summon_ 宏参数缺失 → 整个函数静默失败（无实体）
#arg: cursor, note_idx
# ★ 2026-09-04 健壮性：缺 type 或 position 的音符不生成（防"原点幽灵"：位置/类型未读到 → 展示实体停在原点、默认音符盒贴图）
#   这两个字段为硬性要求；创建时已补默认，异常/旧数据若缺失则跳过渲染（guide/summon 用 #note_valid 守卫）
scoreboard players set #note_valid editor 1
$execute unless data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(note_idx)].type run scoreboard players set #note_valid editor 0
$execute unless data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(note_idx)].position run scoreboard players set #note_valid editor 0
data modify storage rhythm_axe:prop nid set value 0
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(note_idx)].id run execute store result storage rhythm_axe:prop nid int 1 run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(note_idx)].id
data modify storage rhythm_axe:prop pos_x set value 0.0d
# ★ 2026-08-25 用 data modify set from 拆浮点字段：26.x store result storage double/float 会截断小数（0.5→0）
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(note_idx)].position[0] run data modify storage rhythm_axe:prop pos_x set from storage rhythm_axe:maps.editor history[$(cursor)].notes[$(note_idx)].position[0]
data modify storage rhythm_axe:prop pos_y set value 0.0d
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(note_idx)].position[1] run data modify storage rhythm_axe:prop pos_y set from storage rhythm_axe:maps.editor history[$(cursor)].notes[$(note_idx)].position[1]
data modify storage rhythm_axe:prop pos_z set value 0.0d
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(note_idx)].position[2] run data modify storage rhythm_axe:prop pos_z set from storage rhythm_axe:maps.editor history[$(cursor)].notes[$(note_idx)].position[2]
data modify storage rhythm_axe:prop following_point set value 0b
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(note_idx)].following_point run data modify storage rhythm_axe:prop following_point set from storage rhythm_axe:maps.editor history[$(cursor)].notes[$(note_idx)].following_point
data modify storage rhythm_axe:prop start_x set value 0.0d
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(note_idx)].start_pos[0] run data modify storage rhythm_axe:prop start_x set from storage rhythm_axe:maps.editor history[$(cursor)].notes[$(note_idx)].start_pos[0]
data modify storage rhythm_axe:prop start_y set value 0.0d
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(note_idx)].start_pos[1] run data modify storage rhythm_axe:prop start_y set from storage rhythm_axe:maps.editor history[$(cursor)].notes[$(note_idx)].start_pos[1]
data modify storage rhythm_axe:prop start_z set value 24.0d
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(note_idx)].start_pos[2] run data modify storage rhythm_axe:prop start_z set from storage rhythm_axe:maps.editor history[$(cursor)].notes[$(note_idx)].start_pos[2]
data modify storage rhythm_axe:prop size set value 1.0f
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(note_idx)].size run data modify storage rhythm_axe:prop size set from storage rhythm_axe:maps.editor history[$(cursor)].notes[$(note_idx)].size
data modify storage rhythm_axe:prop type set value 0
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(note_idx)].type run execute store result storage rhythm_axe:prop type int 1 run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(note_idx)].type
data modify storage rhythm_axe:prop color set value 0
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(note_idx)].color run execute store result storage rhythm_axe:prop color int 1 run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(note_idx)].color
execute store result storage rhythm_axe:prop lt int 1 run scoreboard players get #n_lt editor
execute store result storage rhythm_axe:prop dur int 1 run scoreboard players get #n_dur editor
execute store result storage rhythm_axe:prop prog1000 int 1 run scoreboard players get #prog editor
# density（混凝土判定密度；缺省 8）
scoreboard players set #n_density editor 8
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(note_idx)].density run execute store result score #n_density editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(note_idx)].density
execute store result storage rhythm_axe:prop density int 1 run scoreboard players get #n_density editor
# ignore_note_speed（玻璃穿过后段随流速缩放开关）：仅字段值为 1(真) 才视为"忽略流速"
# ★ 2026-09-04 修复：按值判断——存在但为 0b(false) 或字段缺省都应随流速缩放（此前"存在即忽略"，慢流速不缩放变快）
scoreboard players set #igv editor 0
$execute store result score #igv editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(note_idx)].ignore_note_speed
data remove storage rhythm_axe:prop ignore_speed
execute if score #igv editor matches 1 run data modify storage rhythm_axe:prop ignore_speed set value 1b

# 生成引导线：统一由 guide_build_for_ 负责（A 指向紧邻下一个音符 B；B 无需开启；未出生音符由 spawn_skip_ 生成）
execute if score #note_valid editor matches 1 run function rhythm_axe:editor/visual/guide_build_for_ with storage rhythm_axe:prop

# 缓动参数（缺省：easing 1 / power 1）
scoreboard players set #n_easing editor 1
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(note_idx)].anim_easing run execute store result score #n_easing editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(note_idx)].anim_easing
scoreboard players set #n_power editor 1
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(note_idx)].anim_power run execute store result score #n_power editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(note_idx)].anim_power
execute store result storage rhythm_axe:prop easing int 1 run scoreboard players get #n_easing editor
execute store result storage rhythm_axe:prop power int 1 run scoreboard players get #n_power editor
# 拆击打反馈参数与音符下标到 prop（★ 必须在 summon_ 之前：summon_ #arg 含 hitsound/hit_particles/idx，缺失会导致整个 summon_ 宏静默失败 → 无实体）
scoreboard players operation #n_hs editor = #n_type editor
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(note_idx)].hitsound run execute store result score #n_hs editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(note_idx)].hitsound
scoreboard players operation #n_hp editor = #n_type editor
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(note_idx)].hit_particles run execute store result score #n_hp editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(note_idx)].hit_particles
execute store result storage rhythm_axe:prop hitsound int 1 run scoreboard players get #n_hs editor
execute store result storage rhythm_axe:prop hit_particles int 1 run scoreboard players get #n_hp editor
$data modify storage rhythm_axe:prop idx set value $(note_idx)
execute if score #note_valid editor matches 1 run function rhythm_axe:editor/visual/summon_ with storage rhythm_axe:prop
# 用后即删宏参数（避免 prop 残留污染其他调用）
data remove storage rhythm_axe:prop nid
data remove storage rhythm_axe:prop pos_x
data remove storage rhythm_axe:prop pos_y
data remove storage rhythm_axe:prop pos_z
data remove storage rhythm_axe:prop start_x
data remove storage rhythm_axe:prop start_y
data remove storage rhythm_axe:prop start_z
data remove storage rhythm_axe:prop size
data remove storage rhythm_axe:prop type
data remove storage rhythm_axe:prop color
data remove storage rhythm_axe:prop following_point
data remove storage rhythm_axe:prop guide_prev
data remove storage rhythm_axe:prop guide_flag
data remove storage rhythm_axe:prop guide_tp
data remove storage rhythm_axe:prop guide_n
data remove storage rhythm_axe:prop guide_sx
data remove storage rhythm_axe:prop guide_sy
data remove storage rhythm_axe:prop guide_sz
data remove storage rhythm_axe:prop lt
data remove storage rhythm_axe:prop dur
data remove storage rhythm_axe:prop prog1000
data remove storage rhythm_axe:prop easing
data remove storage rhythm_axe:prop power
data remove storage rhythm_axe:prop hitsound
data remove storage rhythm_axe:prop hit_particles
data remove storage rhythm_axe:prop idx
