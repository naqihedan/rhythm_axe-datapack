# 桶排序 第4步续：把 notes[$(sort_i)] 整个音符对象 append 进桶 sort_bucket[$(sort_off)]
# 宏参数 sort_i（音符下标）、sort_off（桶下标，调用前已由 fill 写入 storage）
# append 保持原相对顺序 → 稳定排序；游标+1 后递归回 fill 处理下一个音符
#arg: sort_i, sort_off
# 整个音符对象 append 进桶
$execute if data storage rhythm_axe:runtime notes[$(sort_i)]._birth run data modify storage rhythm_axe:runtime sort_bucket[$(sort_off)] append from storage rhythm_axe:runtime notes[$(sort_i)]
# 游标+1
scoreboard players add #sort_i play_state 1
execute store result storage rhythm_axe:runtime sort_i int 1 run scoreboard players get #sort_i play_state
# 未完 → 回 fill 处理下一音符；完 → 合并
# ★ 递归调用行无宏参数 → 不能加 $ 前缀（宏行必须有 $(...)），用普通 execute
execute if score #sort_i play_state < #sort_count play_state run function rhythm_axe:play/start_of_game/sort_bucket_fill with storage rhythm_axe:runtime
# ★ 修复 2026-08-09：分桶完成进 drain 前，重置 #sort_bucket_idx=0（grow 已把它加到 range，drain 需从 0 重新遍历合并）
# ★★ 修复 2026-08-09b（200000 崩溃真根因）：drain 只允许触发一次！
#   put 的 fill 递归返回后，全局 #sort_i 已被最内层 put 加到 #sort_count → 【每一层 put】的
#   `#sort_i >= #sort_count` 判断都成立 → 每层 put 都重置游标并各自跑一遍完整 drain
#   → drain 总层数 = put层数 × range（29×513 ≈ 14877）→ 序列长度爆 200000（设大 limit 则卡死）。
#   用独立标记 #sort_fill_done（init 置 0）保证 drain 恰好执行一次：首个满足条件的 put 执行后置 1。
execute if score #sort_fill_done play_state matches 0 if score #sort_i play_state >= #sort_count play_state run scoreboard players set #sort_bucket_idx play_state 0
execute if score #sort_fill_done play_state matches 0 if score #sort_i play_state >= #sort_count play_state run execute store result storage rhythm_axe:runtime sort_bucket_idx int 1 run scoreboard players get #sort_bucket_idx play_state
execute if score #sort_fill_done play_state matches 0 if score #sort_i play_state >= #sort_count play_state run function rhythm_axe:play/start_of_game/sort_bucket_drain with storage rhythm_axe:runtime
execute if score #sort_fill_done play_state matches 0 if score #sort_i play_state >= #sort_count play_state run scoreboard players set #sort_fill_done play_state 1
