# 桶排序 第3步：把 sort_bucket 扩到 range 个空桶（每个桶 = 一个空数组）
# ★ 2026-09-05 重构：改为【同步普通函数驱动器】递归扩桶。原宏函数递归 range 次（954）触发 26.x
#   宏递归重跑 → 命令爆。普通函数递归每个桶一条调用（954 次 × 每条几条命令 << 200000），不超限。
# ★ 由 sort_bucket_init（建空桶后）进入；扩完 range 个空桶后 → 进入分桶（sort_bucket_fill_drive）。
# 扩一个空桶（未扩完才扩）
scoreboard players set #dbg play_state 17
execute if score #sort_bucket_idx play_state < #sort_range play_state run data modify storage rhythm_axe:runtime sort_bucket append value []
execute if score #sort_bucket_idx play_state < #sort_range play_state run scoreboard players add #sort_bucket_idx play_state 1
execute store result storage rhythm_axe:runtime sort_bucket_idx int 1 run scoreboard players get #sort_bucket_idx play_state
# 未完 → 继续扩（同步普通递归）；扩完 → 进入分桶（普通驱动器 sort_bucket_fill_drive，再经宏叶子入桶）
execute if score #sort_bucket_idx play_state < #sort_range play_state run function rhythm_axe:play/start_of_game/sort_bucket_grow
execute if score #sort_bucket_idx play_state >= #sort_range play_state run function rhythm_axe:play/start_of_game/sort_bucket_fill_drive
