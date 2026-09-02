# 判断音符是否到出生时刻（== time），到则生成一对实体
# 出生时刻已由 scan_birth_one 预计算存入 _birth（time - note_base_life×16/note_speed；ignore_note_speed=true 时为 time - note_base_life）
# 且 init_game 已按 _birth 对 notes 升序排序 → 游标推进正确
#arg: note_idx
$execute if data storage rhythm_axe:runtime notes[$(note_idx)]._birth run execute store result score #birth play_state run data get storage rhythm_axe:runtime notes[$(note_idx)]._birth
# 到出生时刻：把当前音符（含 mapid）复制到 cur_note，坐标拆成标量，再调用生成
# 宏键只允许 a-zA-Z0-9_，数组下标需先拆成 pos_x/y/z、start_x/y/z 标量
$execute if score #birth play_state = time play_state run data modify storage rhythm_axe:runtime cur_note set from storage rhythm_axe:runtime notes[$(note_idx)]
execute if score #birth play_state = time play_state run data modify storage rhythm_axe:runtime cur_note.mapid set from storage rhythm_axe:runtime mapid
$execute if score #birth play_state = time play_state run data modify storage rhythm_axe:runtime cur_note.pos_x set from storage rhythm_axe:runtime notes[$(note_idx)].position[0]
$execute if score #birth play_state = time play_state run data modify storage rhythm_axe:runtime cur_note.pos_y set from storage rhythm_axe:runtime notes[$(note_idx)].position[1]
$execute if score #birth play_state = time play_state run data modify storage rhythm_axe:runtime cur_note.pos_z set from storage rhythm_axe:runtime notes[$(note_idx)].position[2]
$execute if score #birth play_state = time play_state run data modify storage rhythm_axe:runtime cur_note.start_x set from storage rhythm_axe:runtime notes[$(note_idx)].start_pos[0]
$execute if score #birth play_state = time play_state run data modify storage rhythm_axe:runtime cur_note.start_y set from storage rhythm_axe:runtime notes[$(note_idx)].start_pos[1]
$execute if score #birth play_state = time play_state run data modify storage rhythm_axe:runtime cur_note.start_z set from storage rhythm_axe:runtime notes[$(note_idx)].start_pos[2]
execute if score #birth play_state = time play_state run function rhythm_axe:play/note/summon with storage rhythm_axe:runtime cur_note
# 匹配成功：游标+1，并继续检查同一刻的下一个音符（递归）；不匹配则不推进
execute if score #birth play_state = time play_state run scoreboard players add #note_cursor play_state 1
execute store result storage rhythm_axe:runtime note_idx int 1 run scoreboard players get #note_cursor play_state
$execute if score #birth play_state = time play_state if data storage rhythm_axe:runtime notes[$(note_idx)].id run function rhythm_axe:play/note/spawn with storage rhythm_axe:runtime
