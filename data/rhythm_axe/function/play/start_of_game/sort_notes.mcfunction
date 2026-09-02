# 按 _birth 升序重建 runtime.notes（桶排序，替代原冒泡排序 O(n²)）
# 背景：原 sort_pass/sort_step 递归冒泡，最坏 O(n²)。乱序大谱面（如 1420 音符）会展开
#   约百万条命令，超过 max_command_sequence_length 200000 → init_game 中断 → 音符不生成。
# 本实现：桶排序 = 按出生时刻分桶 + 按序合并，O(n + range)。
#   range = max(_birth) - min(_birth) + 1，通常等于谱面时长量级（几百），远小于 n²。
#   任意输入顺序都线性、不超限；append 自然保序 → 稳定（同 _birth 音符保持原相对顺序）。
# 前置：scan_birth_one 已把每个音符的 _birth 写入 notes[]._birth；
#   #earliest_birth play_state 已由 scan_birth 算出（= 最小 _birth，作桶偏移基准）。
# 流程：sort_notes → sort_scan_max(找最大) → sort_bucket_init(建空桶) →
#       sort_bucket_grow(扩桶) → sort_bucket_fill(分桶) → sort_bucket_drain(按序合并) → finish(覆盖 notes)

# 【临时诊断】排序链进入计数器：若 >1，说明排序链被反复执行（外部反复触发 start 或某处循环调用）
scoreboard players add #sort_chain_calls play_state 1
execute store result score #sort_count play_state run data get storage rhythm_axe:runtime notes
# 至少 2 个音符才需要排序
scoreboard players set #sort_i play_state 0
execute store result storage rhythm_axe:runtime sort_i int 1 run scoreboard players get #sort_i play_state
scoreboard players set #sort_max play_state 0
scoreboard players operation #sort_max play_state = #earliest_birth play_state
scoreboard players set #dbg play_state 11
execute if score #sort_count play_state matches 2.. run function rhythm_axe:play/start_of_game/sort_scan_max with storage rhythm_axe:runtime
scoreboard players set #dbg play_state 12
# 清理临时键（桶排序专用 + 旧冒泡残留的 tmp_note/sort_j/sort_jp1）
execute if data storage rhythm_axe:runtime sort_bucket run data remove storage rhythm_axe:runtime sort_bucket
execute if data storage rhythm_axe:runtime sort_sorted run data remove storage rhythm_axe:runtime sort_sorted
execute if data storage rhythm_axe:runtime sort_i run data remove storage rhythm_axe:runtime sort_i
execute if data storage rhythm_axe:runtime sort_off run data remove storage rhythm_axe:runtime sort_off
execute if data storage rhythm_axe:runtime sort_max run data remove storage rhythm_axe:runtime sort_max
execute if data storage rhythm_axe:runtime sort_range run data remove storage rhythm_axe:runtime sort_range
execute if data storage rhythm_axe:runtime sort_bucket_idx run data remove storage rhythm_axe:runtime sort_bucket_idx
execute if data storage rhythm_axe:runtime tmp_note run data remove storage rhythm_axe:runtime tmp_note
execute if data storage rhythm_axe:runtime sort_j run data remove storage rhythm_axe:runtime sort_j
execute if data storage rhythm_axe:runtime sort_jp1 run data remove storage rhythm_axe:runtime sort_jp1
