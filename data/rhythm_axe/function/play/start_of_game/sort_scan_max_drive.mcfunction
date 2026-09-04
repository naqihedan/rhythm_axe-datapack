# 桶排序 第1步驱动器：遍历 notes 找最大 _birth → #sort_max（普通函数，同步）
# ★ 2026-09-05：普通驱动器（无宏参数），用 #sort_i 游标推进；宏叶子 sort_scan_max 处理单音符。
#   扫完 → 调 sort_bucket_init 建桶。
# ★ #sort_init_done 保护：普通递归返回时 #sort_i 已是 #sort_count，每层都会判 #sort_i >= #sort_count 成立
#   → 每层都触发 sort_bucket_init。用标记保证只触发一次（先触发后置 1）。
# 写当前游标到 storage，调宏叶子 sort_scan_max 比较 max
execute store result storage rhythm_axe:runtime sort_i int 1 run scoreboard players get #sort_i play_state
function rhythm_axe:play/start_of_game/sort_scan_max with storage rhythm_axe:runtime
# 游标+1
scoreboard players add #sort_i play_state 1
execute store result storage rhythm_axe:runtime sort_i int 1 run scoreboard players get #sort_i play_state
# 未完 → 继续扫描（同步普通递归，音符数可控）
execute if score #sort_i play_state < #sort_count play_state run function rhythm_axe:play/start_of_game/sort_scan_max_drive
# 扫完 → 仅首个满足者触发一次 init（先触发后置 1）
execute if score #sort_init_done play_state matches 0 if score #sort_i play_state >= #sort_count play_state run function rhythm_axe:play/start_of_game/sort_bucket_init
execute if score #sort_init_done play_state matches 0 if score #sort_i play_state >= #sort_count play_state run scoreboard players set #sort_init_done play_state 1
