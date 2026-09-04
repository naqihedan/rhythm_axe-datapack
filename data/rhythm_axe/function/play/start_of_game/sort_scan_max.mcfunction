# 桶排序 第1步（宏叶子）：读 notes[$(sort_i)]._birth，与 #sort_max 取较大
# ★ 2026-09-05 重构为宏叶子（不递归），遍历由普通驱动器 sort_scan_max_drive 负责。
#arg: sort_i
# 读当前音符 _birth，与 #sort_max 取较大
$execute if data storage rhythm_axe:runtime notes[$(sort_i)]._birth run execute store result score #tmp_birth play_state run data get storage rhythm_axe:runtime notes[$(sort_i)]._birth
execute if score #tmp_birth play_state > #sort_max play_state run scoreboard players operation #sort_max play_state = #tmp_birth play_state
