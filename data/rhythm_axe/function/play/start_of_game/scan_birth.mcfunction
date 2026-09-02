# 遍历 notes，计算所有音符里最早的出生时刻 → #earliest_birth play_state
# 宏参数 scan_idx（读自 rhythm_axe:runtime.scan_idx）
#arg: scan_idx
$execute if data storage rhythm_axe:runtime notes[$(scan_idx)].id run function rhythm_axe:play/start_of_game/scan_birth_one with storage rhythm_axe:runtime
$execute if data storage rhythm_axe:runtime notes[$(scan_idx)].id run scoreboard players add #scan_index play_state 1
execute store result storage rhythm_axe:runtime scan_idx int 1 run scoreboard players get #scan_index play_state
$execute if data storage rhythm_axe:runtime notes[$(scan_idx)].id run function rhythm_axe:play/start_of_game/scan_birth with storage rhythm_axe:runtime
