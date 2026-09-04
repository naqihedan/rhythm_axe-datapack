# 桶排序 第4步驱动器：遍历 notes，逐个交给宏叶子 sort_bucket_fill 入桶（普通函数，同步）
# ★ 2026-09-05：普通驱动器（无宏参数），用 #sort_i 游标推进；宏叶子 fill/put 只处理单音符不递归。
#   分桶遍历音符数（如 336）可控，无需跨刻；每音符调一次宏叶子入桶。
# ★ 由 sort_bucket_grow（扩完 range）进入；分桶完成 → 进合并 sort_bucket_drain（内部 schedule 跨刻）。
# ★ #sort_fill_done 保护（同原 put 方案）：普通递归返回时 #sort_i 已是 #sort_count，
#   每层都会判 #sort_i >= #sort_count 成立 → 每层都触发一次 drain。用标记保证只触发一次。
# 写当前游标到 storage，调宏叶子 sort_bucket_fill 入桶
execute store result storage rhythm_axe:runtime sort_i int 1 run scoreboard players get #sort_i play_state
function rhythm_axe:play/start_of_game/sort_bucket_fill with storage rhythm_axe:runtime
# 游标+1
scoreboard players add #sort_i play_state 1
execute store result storage rhythm_axe:runtime sort_i int 1 run scoreboard players get #sort_i play_state
# 未完 → 继续（同步普通递归，音符数可控）
execute if score #sort_i play_state < #sort_count play_state run function rhythm_axe:play/start_of_game/sort_bucket_fill_drive
# 分桶完成 → 仅首个满足者触发一次 drain（先触发后置 1；后续层 matches 0 为假不再触发）
execute if score #sort_fill_done play_state matches 0 if score #sort_i play_state >= #sort_count play_state run function rhythm_axe:play/start_of_game/sort_bucket_drain
execute if score #sort_fill_done play_state matches 0 if score #sort_i play_state >= #sort_count play_state run scoreboard players set #sort_fill_done play_state 1
