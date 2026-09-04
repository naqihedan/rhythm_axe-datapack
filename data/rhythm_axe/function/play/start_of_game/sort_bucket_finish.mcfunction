# 桶排序 第6步（收尾）：用排好序的 sort_sorted 覆盖 runtime.notes
# ★ 2026-09-05 重构：排序为同步驱动，覆盖 notes 后清理临时键并启动主循环。
# ★ #sort_finish_done 保护：drain_tick 是普通递归，最内层合并完触发本函数，递归返回时每层
#   #sort_bucket_idx >= #sort_range 仍成立 → 每层都会调本函数。用标记保证只执行一次（含启动主循环）。
# 覆盖 notes（仅首次）
execute if score #sort_finish_done play_state matches 0 run execute if data storage rhythm_axe:runtime notes run data remove storage rhythm_axe:runtime notes
execute if score #sort_finish_done play_state matches 0 run data modify storage rhythm_axe:runtime notes set from storage rhythm_axe:runtime sort_sorted
# 清理桶排序临时键（跨刻/同步结束后；仅首次）
execute if score #sort_finish_done play_state matches 0 run execute if data storage rhythm_axe:runtime sort_bucket run data remove storage rhythm_axe:runtime sort_bucket
execute if score #sort_finish_done play_state matches 0 run execute if data storage rhythm_axe:runtime sort_sorted run data remove storage rhythm_axe:runtime sort_sorted
execute if score #sort_finish_done play_state matches 0 run execute if data storage rhythm_axe:runtime sort_i run data remove storage rhythm_axe:runtime sort_i
execute if score #sort_finish_done play_state matches 0 run execute if data storage rhythm_axe:runtime sort_off run data remove storage rhythm_axe:runtime sort_off
execute if score #sort_finish_done play_state matches 0 run execute if data storage rhythm_axe:runtime sort_max run data remove storage rhythm_axe:runtime sort_max
execute if score #sort_finish_done play_state matches 0 run execute if data storage rhythm_axe:runtime sort_range run data remove storage rhythm_axe:runtime sort_range
execute if score #sort_finish_done play_state matches 0 run execute if data storage rhythm_axe:runtime sort_bucket_idx run data remove storage rhythm_axe:runtime sort_bucket_idx
execute if score #sort_finish_done play_state matches 0 run execute if data storage rhythm_axe:runtime sort_step_run run data remove storage rhythm_axe:runtime sort_step_run
# 排序完成标记（仅首次）+ 启动主循环（仅首次，先调用后置 1；递归返回层 matches 0 为假不再启动）
scoreboard players set #sort_done play_state 1
execute if score #sort_finish_done play_state matches 0 run function rhythm_axe:play/start_of_game/sort_start_main
execute if score #sort_finish_done play_state matches 0 run scoreboard players set #sort_finish_done play_state 1
