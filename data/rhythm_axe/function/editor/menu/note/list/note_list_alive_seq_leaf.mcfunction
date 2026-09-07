#arg:cursor,alive_idx
# 叶子（宏）：判断当前 alive_idx 音符是否存活，据此把"数组存活序"写入 prop.alive_seq
# 存活 → append 存活序(#alive_c) + #alive_c+1；非存活 → append -1
# 存活判定与 note_list_row2 / note_find_alive 完全一致（出生刻/消失刻公式）
# 先算 #note_total（供驱动器判断越界）
scoreboard players set #note_total editor 0
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes run execute store result score #note_total editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes
scoreboard players set #is_alive editor 1
$execute unless data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(alive_idx)].id run scoreboard players set #is_alive editor 0
# 出生刻
scoreboard players set #temp_playhead editor 0
execute store result score #temp_playhead editor run data get storage rhythm_axe:maps.editor playhead
scoreboard players set #temp_cursor editor 32
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(alive_idx)].note_base_life run execute store result score #temp_cursor editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(alive_idx)].note_base_life
scoreboard players set #temp_ig editor 0
$execute store result score #temp_ig editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(alive_idx)].ignore_note_speed
$execute store result score #temp editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(alive_idx)].time
execute if score #temp_ig editor matches 1 run scoreboard players operation #temp editor -= #temp_cursor editor
execute if score #temp_ig editor matches 0 run scoreboard players operation #temp_cursor editor *= 16 const
execute if score #temp_ig editor matches 0 run scoreboard players operation #temp_cursor editor /= note_speed options
execute if score #temp_ig editor matches 0 run scoreboard players operation #temp editor -= #temp_cursor editor
scoreboard players set #temp_type editor 0
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(alive_idx)].type run execute store result score #temp_type editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(alive_idx)].type
scoreboard players set #temp_pow editor 1
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(alive_idx)].anim_power run execute store result score #temp_pow editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(alive_idx)].anim_power
execute if score #temp_type editor matches 0..2 if score #temp_pow editor matches 1 run scoreboard players remove #temp editor 4
scoreboard players set #temp_dur editor 3
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(alive_idx)].duration run execute store result score #temp_dur editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(alive_idx)].duration
execute if score #temp_type editor matches 4 if score #temp_pow editor matches 1 if score #temp_dur editor matches 1.. run scoreboard players remove #temp editor 4
execute if score #temp_playhead editor < #temp editor run scoreboard players set #is_alive editor 0
# 消失刻
scoreboard players set #temp_cursor editor 0
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(alive_idx)].duration run execute store result score #temp_cursor editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(alive_idx)].duration
scoreboard players set #temp_type editor 0
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(alive_idx)].type run execute store result score #temp_type editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(alive_idx)].type
$execute store result score #temp editor run data get storage rhythm_axe:maps.editor history[$(cursor)].notes[$(alive_idx)].time
execute if score #temp_type editor matches 3 run scoreboard players operation #temp editor += #temp_cursor editor
execute if score #temp_type editor matches 3 run scoreboard players remove #temp editor 1
execute if score #temp_type editor matches 4 run scoreboard players operation #temp editor += #temp_cursor editor
execute if score #temp_type editor matches 4 run scoreboard players add #temp editor 1
execute if score #temp_playhead editor > #temp editor run scoreboard players set #is_alive editor 0
# 写入 alive_seq
execute if score #is_alive editor matches 1 run data modify storage rhythm_axe:prop alive_seq append value 0
execute if score #is_alive editor matches 1 run execute store result storage rhythm_axe:prop alive_seq[-1] int 1 run scoreboard players get #alive_c editor
execute if score #is_alive editor matches 1 run scoreboard players add #alive_c editor 1
execute unless score #is_alive editor matches 1 run data modify storage rhythm_axe:prop alive_seq append value -1
