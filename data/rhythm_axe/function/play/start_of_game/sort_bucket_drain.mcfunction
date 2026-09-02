# 桶排序 第5步：按桶下标 0..range-1 顺序，把每个桶整体 append 到 sort_sorted
# 桶下标递增 = _birth 递增 → 合并结果即按 _birth 升序
# 宏参数 sort_bucket_idx（读自 storage sort_bucket_idx）
# 注意：空桶也有（扩容时建了 range 个），[] 后缀展开空数组无效果，安全
#arg: sort_bucket_idx
scoreboard players set #dbg play_state 16
# 把当前桶的每个元素逐项 append 到 sort_sorted（[] 后缀 = 数组元素逐个展开）
$execute if data storage rhythm_axe:runtime sort_bucket[$(sort_bucket_idx)] run data modify storage rhythm_axe:runtime sort_sorted append from storage rhythm_axe:runtime sort_bucket[$(sort_bucket_idx)][]
scoreboard players add #sort_bucket_idx play_state 1
execute store result storage rhythm_axe:runtime sort_bucket_idx int 1 run scoreboard players get #sort_bucket_idx play_state
# 未完 → 继续合并；完 → 覆盖 notes
# ★ 递归调用行无宏参数 → 不能加 $ 前缀（宏行必须有 $(...)），用普通 execute
execute if score #sort_bucket_idx play_state < #sort_range play_state run function rhythm_axe:play/start_of_game/sort_bucket_drain with storage rhythm_axe:runtime
execute if score #sort_bucket_idx play_state >= #sort_range play_state run function rhythm_axe:play/start_of_game/sort_bucket_finish with storage rhythm_axe:runtime
