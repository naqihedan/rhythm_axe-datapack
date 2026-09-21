# 补扫单步（宏叶子，不递归）：只处理 notes[$(note_idx)]
#   越界 → #due_stop=1 结束；窗口外（time − playhead > 最大前导）→ #due_stop=1（后面 time 更大，更不可能本刻出生）
#   本刻出生（birth == playhead）→ 交给 spawn_one_ 正常生成
#     （spawn_one_ 自带 playhead∈[birth,end] 守卫、以及「已过判定时刻的普通音符」快速跳过，安全可复用）
#arg: cursor, note_idx
$execute unless data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(note_idx)].id run scoreboard players set #due_stop editor 1
$execute unless data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(note_idx)].id run return 0
$execute store result score #n_time editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(note_idx)].time
scoreboard players set #n_lt editor 32
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(note_idx)].note_base_life run execute store result score #n_lt editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(note_idx)].note_base_life
scoreboard players set #ig_on editor 0
$execute store result score #ig_on editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(note_idx)].ignore_note_speed
scoreboard players operation #n_birth editor = #n_time editor
execute if score #ig_on editor matches 1 run scoreboard players operation #n_birth editor -= #n_lt editor
scoreboard players operation #tmp_vis editor = #n_lt editor
scoreboard players operation #tmp_vis editor *= 16 const
scoreboard players operation #tmp_vis editor /= note_speed options
execute if score #ig_on editor matches 0 run scoreboard players operation #n_birth editor -= #tmp_vis editor
scoreboard players operation #due_gap editor = #n_time editor
scoreboard players operation #due_gap editor -= #playhead editor
execute if score #due_gap editor > #due_max editor run scoreboard players set #due_stop editor 1
execute if score #due_gap editor > #due_max editor run return 0
execute if score #n_birth editor = #playhead editor run function rhythm_axe:editor/visual/spawn_one_ with storage rhythm_axe:prop
