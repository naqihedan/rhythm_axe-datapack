# 按 _birth 升序重建 runtime.notes（桶排序，替代原冒泡排序 O(n²)）
# ★ 2026-09-05 跨多刻重构：排序用 schedule 跨多个游戏刻执行，避免单刻命令序列超 200000。
#   背景：原 sort_bucket_grow/drain 宏函数递归 range 次（如 954）→ 26.x 宏递归重跑残留代码，
#   命令数爆 200000。现改为"普通函数驱动器 + schedule 推进 + 宏叶子"，每刻处理 #sort_step 个桶。
# 流程：sort_notes → sort_scan_max(找最大) → sort_bucket_init(建空桶+算 range，末尾启动 grow schedule)
#      → sort_bucket_grow(跨刻扩桶) → sort_bucket_fill/put(宏叶子分桶) → sort_bucket_drain(跨刻合并)
#      → sort_bucket_finish(覆盖 notes + 清理临时键 + 启动 main_loop)
# 前置：scan_birth_one 已把每个音符的 _birth 写入 notes[]._birth；
#   #earliest_birth play_state 已由 scan_birth 算出（= 最小 _birth，作桶偏移基准）。
# ★ 本函数只做初始化 + 启动链；不再同步递归，也不再清理 sort_* 键（那些在 finish 时清理）。
execute store result score #sort_count play_state run data get storage rhythm_axe:runtime notes
# 至少 2 个音符才需要排序（1 个或 0 个直接启动主循环）
scoreboard players set #sort_i play_state 0
execute store result storage rhythm_axe:runtime sort_i int 1 run scoreboard players get #sort_i play_state
scoreboard players set #sort_max play_state 0
scoreboard players operation #sort_max play_state = #earliest_birth play_state
scoreboard players set #dbg play_state 11
# ★ 每刻处理的桶数（已改用同步递归，不再跨刻；此值保留但不再用于分批）
scoreboard players set #sort_step play_state 60
# 完成保护标记初始化（驱动递归防重复触发用）
scoreboard players set #sort_init_done play_state 0
scoreboard players set #sort_fill_done play_state 0
scoreboard players set #sort_finish_done play_state 0
# ★ 只在 >=2 个音符时才排序；否则直接置排序完成标记并启动主循环
execute if score #sort_count play_state matches 1 run scoreboard players set #sort_done play_state 1
execute if score #sort_count play_state matches 0 run scoreboard players set #sort_done play_state 1
execute if score #sort_count play_state matches 2.. run function rhythm_axe:play/start_of_game/sort_scan_max_drive
# ≤1 个音符 → 无需要排序，直接启动主循环
execute if score #sort_count play_state matches ..1 run function rhythm_axe:play/start_of_game/sort_start_main
execute if data storage rhythm_axe:runtime tmp_note run data remove storage rhythm_axe:runtime tmp_note
execute if data storage rhythm_axe:runtime sort_j run data remove storage rhythm_axe:runtime sort_j
execute if data storage rhythm_axe:runtime sort_jp1 run data remove storage rhythm_axe:runtime sort_jp1
