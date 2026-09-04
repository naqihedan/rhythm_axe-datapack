# 桶排序 第5步：按桶下标 0..range-1 顺序，把每个桶整体 append 到 sort_sorted
# 桶下标递增 = _birth 递增 → 合并结果即按 _birth 升序
# ★ 2026-09-05 重构：改为【同步普通函数驱动器】递归合并。原宏函数递归 range 次（954）触发 26.x
#   宏递归重跑 → 命令爆。普通函数递归每个桶一条调用（954 次 × 每条几条命令 << 200000），不超限。
#   单个桶的合并用宏叶子 sort_bucket_drain_one（#arg: sort_bucket_idx）。
# ★ 被 fill_drive 分桶完成后调用。重置桶下标并启动同步驱动器。
scoreboard players set #dbg play_state 16
scoreboard players set #sort_bucket_idx play_state 0
execute store result storage rhythm_axe:runtime sort_bucket_idx int 1 run scoreboard players get #sort_bucket_idx play_state
function rhythm_axe:play/start_of_game/sort_bucket_drain_tick
