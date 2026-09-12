#arg:cursor,index
# 把批量增量应用到单个音符（宏叶子，不递归）；仅 history[$(cursor)].notes[$(index)] 行需 $ 前缀
# 相对/绝对用计分板 #rele 判断（1=相对增量，0=绝对同值 editing.temp），避免 if data storage 对字节 0b 也为真。
# 判定时间（整数刻，下界 0）
scoreboard players set #rele editor 0
execute store result score #rele editor run data get storage rhythm_axe:maps.editor editing.rel.on.time
$execute if score #rele editor matches 1 run execute store result score #t editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].time
execute if score #rele editor matches 1 run execute store result score #d editor run data get storage rhythm_axe:maps.editor editing.rel.delta.time
execute if score #rele editor matches 1 run scoreboard players operation #t editor += #d editor
execute if score #rele editor matches 1 if score #t editor matches ..-1 run scoreboard players set #t editor 0
$execute if score #rele editor matches 1 run execute store result storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].time int 1 run scoreboard players get #t editor
$execute unless score #rele editor matches 1 if data storage rhythm_axe:maps.editor editing.batch_set.time run data modify storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].time set from storage rhythm_axe:maps.editor editing.temp.time
# 大小（float，下界 0.1；delta 为 ×100 整数）
scoreboard players set #rele editor 0
execute store result score #rele editor run data get storage rhythm_axe:maps.editor editing.rel.on.size
$execute if score #rele editor matches 1 run execute store result score #v editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].size 1000
execute if score #rele editor matches 1 run scoreboard players operation #v editor += 5 const
execute if score #rele editor matches 1 run scoreboard players operation #v editor /= 10 const
execute if score #rele editor matches 1 run execute store result score #d editor run data get storage rhythm_axe:maps.editor editing.rel.delta.size
execute if score #rele editor matches 1 run scoreboard players operation #v editor += #d editor
execute if score #rele editor matches 1 if score #v editor matches ..10 run scoreboard players set #v editor 10
$execute if score #rele editor matches 1 run execute store result storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].size float 0.01 run scoreboard players get #v editor
$execute unless score #rele editor matches 1 if data storage rhythm_axe:maps.editor editing.batch_set.size run data modify storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].size set from storage rhythm_axe:maps.editor editing.temp.size
# 判定位置 x/y/z（无下界钳制；delta 为 ×100 整数）
scoreboard players set #rele editor 0
execute store result score #rele editor run data get storage rhythm_axe:maps.editor editing.rel.on.position
$execute if score #rele editor matches 1 run execute store result score #v editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].position[0] 1000
execute if score #rele editor matches 1 run scoreboard players operation #v editor += 5 const
execute if score #rele editor matches 1 run scoreboard players operation #v editor /= 10 const
execute if score #rele editor matches 1 run execute store result score #d editor run data get storage rhythm_axe:maps.editor editing.rel.delta.position[0]
execute if score #rele editor matches 1 run scoreboard players operation #v editor += #d editor
$execute if score #rele editor matches 1 run execute store result storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].position[0] double 0.01 run scoreboard players get #v editor
$execute if score #rele editor matches 1 run execute store result score #v editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].position[1] 1000
execute if score #rele editor matches 1 run scoreboard players operation #v editor += 5 const
execute if score #rele editor matches 1 run scoreboard players operation #v editor /= 10 const
execute if score #rele editor matches 1 run execute store result score #d editor run data get storage rhythm_axe:maps.editor editing.rel.delta.position[1]
execute if score #rele editor matches 1 run scoreboard players operation #v editor += #d editor
$execute if score #rele editor matches 1 run execute store result storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].position[1] double 0.01 run scoreboard players get #v editor
$execute if score #rele editor matches 1 run execute store result score #v editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].position[2] 1000
execute if score #rele editor matches 1 run scoreboard players operation #v editor += 5 const
execute if score #rele editor matches 1 run scoreboard players operation #v editor /= 10 const
execute if score #rele editor matches 1 run execute store result score #d editor run data get storage rhythm_axe:maps.editor editing.rel.delta.position[2]
execute if score #rele editor matches 1 run scoreboard players operation #v editor += #d editor
$execute if score #rele editor matches 1 run execute store result storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].position[2] double 0.01 run scoreboard players get #v editor
$execute unless score #rele editor matches 1 if data storage rhythm_axe:maps.editor editing.batch_set.position run data modify storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].position set from storage rhythm_axe:maps.editor editing.temp.position
# 起始位置 x/y/z（无下界钳制；delta 为 ×100 整数）
scoreboard players set #rele editor 0
execute store result score #rele editor run data get storage rhythm_axe:maps.editor editing.rel.on.start_pos
$execute if score #rele editor matches 1 run execute store result score #v editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].start_pos[0] 1000
execute if score #rele editor matches 1 run scoreboard players operation #v editor += 5 const
execute if score #rele editor matches 1 run scoreboard players operation #v editor /= 10 const
execute if score #rele editor matches 1 run execute store result score #d editor run data get storage rhythm_axe:maps.editor editing.rel.delta.start_pos[0]
execute if score #rele editor matches 1 run scoreboard players operation #v editor += #d editor
$execute if score #rele editor matches 1 run execute store result storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].start_pos[0] double 0.01 run scoreboard players get #v editor
$execute if score #rele editor matches 1 run execute store result score #v editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].start_pos[1] 1000
execute if score #rele editor matches 1 run scoreboard players operation #v editor += 5 const
execute if score #rele editor matches 1 run scoreboard players operation #v editor /= 10 const
execute if score #rele editor matches 1 run execute store result score #d editor run data get storage rhythm_axe:maps.editor editing.rel.delta.start_pos[1]
execute if score #rele editor matches 1 run scoreboard players operation #v editor += #d editor
$execute if score #rele editor matches 1 run execute store result storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].start_pos[1] double 0.01 run scoreboard players get #v editor
$execute if score #rele editor matches 1 run execute store result score #v editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].start_pos[2] 1000
execute if score #rele editor matches 1 run scoreboard players operation #v editor += 5 const
execute if score #rele editor matches 1 run scoreboard players operation #v editor /= 10 const
execute if score #rele editor matches 1 run execute store result score #d editor run data get storage rhythm_axe:maps.editor editing.rel.delta.start_pos[2]
execute if score #rele editor matches 1 run scoreboard players operation #v editor += #d editor
$execute if score #rele editor matches 1 run execute store result storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].start_pos[2] double 0.01 run scoreboard players get #v editor
$execute unless score #rele editor matches 1 if data storage rhythm_axe:maps.editor editing.batch_set.start_pos run data modify storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].start_pos set from storage rhythm_axe:maps.editor editing.temp.start_pos
# 同值字段（仅应用有 batch_set 标记的，避免默认值覆盖）
$execute if data storage rhythm_axe:maps.editor editing.batch_set.type run data modify storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].type set from storage rhythm_axe:maps.editor editing.temp.type
$execute if data storage rhythm_axe:maps.editor editing.batch_set.base_life run data modify storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].note_base_life set from storage rhythm_axe:maps.editor editing.temp.note_base_life
# 持续时长（整数刻，下界 0）：相对=原值+增量；绝对=有 batch_set 标记时写同值
scoreboard players set #rele_d editor 0
execute store result score #rele_d editor run data get storage rhythm_axe:maps.editor editing.rel.on.duration
$execute if score #rele_d editor matches 1 run execute store result score #t editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].duration
execute if score #rele_d editor matches 1 run execute store result score #d editor run data get storage rhythm_axe:maps.editor editing.rel.delta.duration
execute if score #rele_d editor matches 1 run scoreboard players operation #t editor += #d editor
execute if score #rele_d editor matches 1 if score #t editor matches ..-1 run scoreboard players set #t editor 0
$execute if score #rele_d editor matches 1 run execute store result storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].duration int 1 run scoreboard players get #t editor
$execute unless score #rele_d editor matches 1 if data storage rhythm_axe:maps.editor editing.batch_set.duration run data modify storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].duration set from storage rhythm_axe:maps.editor editing.temp.duration
$execute if data storage rhythm_axe:maps.editor editing.batch_set.color run data modify storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].color set from storage rhythm_axe:maps.editor editing.temp.color
$execute if data storage rhythm_axe:maps.editor editing.batch_set.density run data modify storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].density set from storage rhythm_axe:maps.editor editing.temp.density
$execute if data storage rhythm_axe:maps.editor editing.batch_set.anim_easing run data modify storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].anim_easing set from storage rhythm_axe:maps.editor editing.temp.anim_easing
$execute if data storage rhythm_axe:maps.editor editing.batch_set.anim_power run data modify storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].anim_power set from storage rhythm_axe:maps.editor editing.temp.anim_power
$execute if data storage rhythm_axe:maps.editor editing.batch_set.hitsound run data modify storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].hitsound set from storage rhythm_axe:maps.editor editing.temp.hitsound
$execute if data storage rhythm_axe:maps.editor editing.batch_set.hit_particles run data modify storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].hit_particles set from storage rhythm_axe:maps.editor editing.temp.hit_particles
$execute if data storage rhythm_axe:maps.editor editing.batch_set.custom_tag run data modify storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].custom_tag set from storage rhythm_axe:maps.editor editing.temp.custom_tag
$execute if data storage rhythm_axe:maps.editor editing.batch_set.following_point run data modify storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].following_point set from storage rhythm_axe:maps.editor editing.temp.following_point
$execute if data storage rhythm_axe:maps.editor editing.batch_set.ignore_note_speed run data modify storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].ignore_note_speed set from storage rhythm_axe:maps.editor editing.temp.ignore_note_speed
$execute if data storage rhythm_axe:maps.editor editing.batch_set.hit_events run data modify storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].hit_events set from storage rhythm_axe:maps.editor editing.temp.hit_events
$execute if data storage rhythm_axe:maps.editor editing.batch_set.hit_events run data modify storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].hit_events set from storage rhythm_axe:maps.editor editing.temp.hit_events
