# 桶排序 第3步：把 sort_bucket 扩到 range 个空桶（每个桶 = 一个空数组）
# 宏参数 sort_bucket_idx（读自 storage sort_bucket_idx）
# 用 append value [] 逐次追加空数组；追加 range 次后 → 分桶
#arg: sort_bucket_idx
scoreboard players set #dbg play_state 17
data modify storage rhythm_axe:runtime sort_bucket append value []
scoreboard players add #sort_bucket_idx play_state 1
execute store result storage rhythm_axe:runtime sort_bucket_idx int 1 run scoreboard players get #sort_bucket_idx play_state
# 未完 → 继续扩；完 → 分桶
# ★ 递归调用行无宏参数 → 不能加 $ 前缀（宏行必须有 $(...)），用普通 execute
execute if score #sort_bucket_idx play_state < #sort_range play_state run function rhythm_axe:play/start_of_game/sort_bucket_grow with storage rhythm_axe:runtime
execute if score #sort_bucket_idx play_state >= #sort_range play_state run function rhythm_axe:play/start_of_game/sort_bucket_fill with storage rhythm_axe:runtime
