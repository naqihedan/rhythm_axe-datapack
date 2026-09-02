#arg: cursor, index
# 遍历 notes 计算最早出生时刻 → #earliest_birth（editor objective）；调用前设 #earliest_birth = 1000000
# 出生 = time - note_base_life×16/note_speed（ignore_note_speed 时 = time - note_base_life），与 spawn_one_ 一致
$execute unless data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)] run return 0
$execute store result score #n_time editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].time
scoreboard players set #n_lt editor 32
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].note_base_life run execute store result score #n_lt editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].note_base_life
scoreboard players operation #birth editor = #n_time editor
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].ignore_note_speed run scoreboard players operation #birth editor -= #n_lt editor
scoreboard players operation #tmp editor = #n_lt editor
scoreboard players operation #tmp editor *= 16 const
scoreboard players operation #tmp editor /= note_speed options
$execute unless data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)].ignore_note_speed run scoreboard players operation #birth editor -= #tmp editor
execute if score #birth editor < #earliest_birth editor run scoreboard players operation #earliest_birth editor = #birth editor
# 继续遍历
execute store result score #index editor run data get storage rhythm_axe:prop index
scoreboard players add #index editor 1
execute store result storage rhythm_axe:prop index int 1 run scoreboard players get #index editor
function rhythm_axe:editor/visual/scan_birth with storage rhythm_axe:prop
