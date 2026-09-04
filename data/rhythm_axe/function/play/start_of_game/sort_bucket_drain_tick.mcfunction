# 桶排序 第5步驱动器：合并当前桶到 sort_sorted（同步普通递归，每桶一次）
# ★ 2026-09-05：普通函数（无宏参数），批内同步递归合并所有桶（range 次 << 200000，不超限）。
#   单个桶合并走宏叶子 sort_bucket_drain_one（#arg: sort_bucket_idx）。
#   递归返回时各层 #sort_bucket_idx >= range 成立 → 每层都会触发 finish，故用 #sort_finish_done 保护。
# 合并一个桶（把 #sort_bucket_idx 写 storage 供宏叶子读）
execute store result storage rhythm_axe:runtime sort_bucket_idx int 1 run scoreboard players get #sort_bucket_idx play_state
function rhythm_axe:play/start_of_game/sort_bucket_drain_one with storage rhythm_axe:runtime
# 推进桶下标
scoreboard players add #sort_bucket_idx play_state 1
execute store result storage rhythm_axe:runtime sort_bucket_idx int 1 run scoreboard players get #sort_bucket_idx play_state
# 未完 → 继续合并（同步普通递归）；完 → 覆盖 notes
execute if score #sort_bucket_idx play_state < #sort_range play_state run function rhythm_axe:play/start_of_game/sort_bucket_drain_tick
execute if score #sort_bucket_idx play_state >= #sort_range play_state run function rhythm_axe:play/start_of_game/sort_bucket_finish
