# 桶排序 第6步（收尾）：用排好序的 sort_sorted 覆盖 runtime.notes
# 覆盖后 notes 按 _birth 升序，生成游标（spawn/spawn_one）即可正确推进
# 临时键（sort_bucket/sort_sorted/sort_i/sort_off/sort_max/sort_range/sort_bucket_idx）
# 由 sort_notes 末尾统一清理（reload 兜底处）
execute if data storage rhythm_axe:runtime notes run data remove storage rhythm_axe:runtime notes
data modify storage rhythm_axe:runtime notes set from storage rhythm_axe:runtime sort_sorted
