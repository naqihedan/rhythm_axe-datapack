# 桶排序 第1步：遍历 notes 找最大 _birth → #sort_max（桶数量上限 = max-min+1）
# 宏参数 sort_i（读自 storage sort_i）
# 游标模式与 scan_birth 相同：宏参数是调用时刻 storage 快照，递归前须把新游标写回 storage
#arg: sort_i
# 读当前音符 _birth，与 #sort_max 取较大
$execute if data storage rhythm_axe:runtime notes[$(sort_i)]._birth run execute store result score #tmp_birth play_state run data get storage rhythm_axe:runtime notes[$(sort_i)]._birth
execute if score #tmp_birth play_state > #sort_max play_state run scoreboard players operation #sort_max play_state = #tmp_birth play_state
# 游标+1
scoreboard players add #sort_i play_state 1
execute store result storage rhythm_axe:runtime sort_i int 1 run scoreboard players get #sort_i play_state
# 未完 → 继续扫描；完 → 建桶
# ★ 递归调用行无宏参数 → 不能加 $ 前缀（宏行必须有 $(...)），用普通 execute
execute if score #sort_i play_state < #sort_count play_state run function rhythm_axe:play/start_of_game/sort_scan_max with storage rhythm_axe:runtime
execute if score #sort_i play_state >= #sort_count play_state run function rhythm_axe:play/start_of_game/sort_bucket_init with storage rhythm_axe:runtime
