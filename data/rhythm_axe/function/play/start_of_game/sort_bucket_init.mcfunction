# 桶排序 第2步：计算桶数 range = max-min+1，建空桶数组（range 个空数组），开始扩容
# 桶索引 = _birth - #earliest_birth（最小 _birth 作偏移基准 → 桶下标从 0 连续到 range-1）
# 桶数组结构：sort_bucket = [ 桶0[], 桶1[], ... ]（每个桶是个数组，装该出生时刻的音符）
scoreboard players operation #sort_range play_state = #sort_max play_state
scoreboard players operation #sort_range play_state -= #earliest_birth play_state
scoreboard players add #sort_range play_state 1
# ★ 修复 2026-08-09：#sort_i 在 sort_scan_max 结束时已 = #sort_count，分桶 fill 必须从 0 重新遍历 → 重置回 0
scoreboard players set #sort_i play_state 0
execute store result storage rhythm_axe:runtime sort_i int 1 run scoreboard players get #sort_i play_state
scoreboard players set #dbg play_state 13
# 【临时诊断】init 进入计数器：与 #sort_chain_calls 对比定位（= 应等于 [排序诊断] 打印次数）
scoreboard players add #sort_init_calls play_state 1
# 【临时诊断】打印排序关键值
tellraw @a [{"text":"[排序诊断] ","color":"gold"},{"text":"max=","color":"white"},{"score":{"objective":"play_state","name":"#sort_max"}},{"text":" earliest=","color":"white"},{"score":{"objective":"play_state","name":"#earliest_birth"}},{"text":" range=","color":"white"},{"score":{"objective":"play_state","name":"#sort_range"}}]
data modify storage rhythm_axe:runtime sort_bucket set value []
# 合并结果列表先建空（后续 append from 需要目标已存在）
data modify storage rhythm_axe:runtime sort_sorted set value []
# ★★ 修复 2026-08-09b：drain 只允许触发一次标记（分桶完成进 drain 前由 put 检查；首个满足者执行后置 1）
scoreboard players set #sort_fill_done play_state 0
scoreboard players set #sort_bucket_idx play_state 0
execute store result storage rhythm_axe:runtime sort_bucket_idx int 1 run scoreboard players get #sort_bucket_idx play_state
function rhythm_axe:play/start_of_game/sort_bucket_grow with storage rhythm_axe:runtime
scoreboard players set #dbg play_state 14
