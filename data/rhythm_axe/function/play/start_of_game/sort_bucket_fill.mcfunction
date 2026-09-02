# 桶排序 第4步：遍历 notes，对每个音符算出桶下标 off，交给 sort_bucket_put 放入桶
# 桶下标 off = _birth - #earliest_birth（0 起连续），天然按出生时刻分组且保序
# 宏参数 sort_i（读自 storage sort_i）
# ★ 宏陷阱：$(sort_off) 是"调用 sort_bucket_put 那一刻"storage 的值 → 本函数算好 off
#   写入 storage 后必须【跨函数】让 put 读到，不能在本函数内直接 $(sort_off)（整体展开会取旧值）
#arg: sort_i
scoreboard players set #dbg play_state 15
# 读当前音符 _birth → 算桶下标 off
$execute if data storage rhythm_axe:runtime notes[$(sort_i)]._birth run execute store result score #tmp_birth play_state run data get storage rhythm_axe:runtime notes[$(sort_i)]._birth
scoreboard players operation #sort_off play_state = #tmp_birth play_state
scoreboard players operation #sort_off play_state -= #earliest_birth play_state
execute store result storage rhythm_axe:runtime sort_off int 1 run scoreboard players get #sort_off play_state
# 交给 put 入桶（put 里用快照的 $(sort_i) 与 $(sort_off)）
$execute if data storage rhythm_axe:runtime notes[$(sort_i)]._birth run function rhythm_axe:play/start_of_game/sort_bucket_put with storage rhythm_axe:runtime
