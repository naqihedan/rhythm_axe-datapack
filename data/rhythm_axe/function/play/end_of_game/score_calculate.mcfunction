# 分数结算：计算分数、更新最高分、把当前血量换算为百分比
# 读取 play_state（判定计数/分数/血量），权重读 score_calculate
# ★ 宏函数（2026-08-09）：需要 mapid 访问谱面 storage（rhythm_axe:maps.<mapid>）读写最高分
#   由 end_of_game 以 with storage rhythm_axe:runtime 调用（runtime.mapid 由 start 写入）
#arg: mapid
scoreboard objectives add score_calculate dummy
# 最终分数 = (P×1st + G×2nd + M×3rd) / ((P+G+M)×1st) × 100000

# 分数计算初始化
scoreboard players set num_perfect score_calculate 0
scoreboard players set num_good score_calculate 0
scoreboard players set num_miss score_calculate 0

scoreboard players set max_weight score_calculate 0
scoreboard players set num_1th_weight score_calculate 0
scoreboard players set num_2nd_weight score_calculate 0
scoreboard players set num_3rd_weight score_calculate 0

scoreboard players set score score_calculate 0
scoreboard players set percentage_health score_calculate 0

# 统计三种判定个数
scoreboard players operation num_perfect score_calculate += perfect play_state
scoreboard players operation num_perfect score_calculate += perfect_early play_state
scoreboard players operation num_perfect score_calculate += perfect_late play_state

scoreboard players operation num_good score_calculate += good_early play_state
scoreboard players operation num_good score_calculate += good_late play_state

scoreboard players operation num_miss score_calculate += miss play_state
scoreboard players operation num_miss score_calculate += bad play_state

# 汇总到展示用计数（Perfect/Good/Miss 三档；result_display 从 score_calculate 读取）
scoreboard players operation perfect score_calculate = num_perfect score_calculate
scoreboard players operation good score_calculate = num_good score_calculate
scoreboard players operation miss score_calculate = num_miss score_calculate

# 计算总权重与各级判定权重
scoreboard players operation max_weight score_calculate += num_perfect score_calculate
scoreboard players operation max_weight score_calculate += num_good score_calculate
scoreboard players operation max_weight score_calculate += num_miss score_calculate
scoreboard players operation max_weight score_calculate *= 1th_weight score_calculate

scoreboard players operation num_1th_weight score_calculate = num_perfect score_calculate
scoreboard players operation num_1th_weight score_calculate *= 1th_weight score_calculate

scoreboard players operation num_2nd_weight score_calculate += num_good score_calculate
scoreboard players operation num_2nd_weight score_calculate *= 2nd_weight score_calculate

scoreboard players operation num_3rd_weight score_calculate += num_miss score_calculate
scoreboard players operation num_3rd_weight score_calculate *= 3rd_weight score_calculate

# 汇总并计算最终分数
scoreboard players operation score score_calculate += num_1th_weight score_calculate
scoreboard players operation score score_calculate += num_2nd_weight score_calculate
scoreboard players operation score score_calculate += num_3rd_weight score_calculate
scoreboard players operation score score_calculate *= 100000 const
scoreboard players operation score score_calculate /= max_weight score_calculate

# 传给游玩状态计分板（score 供 result_display 显示）
scoreboard players operation score play_state = score score_calculate

# ★ 更新最高分（存于谱面 storage，每谱面独立、持久化；play_state.highest_score 仅结算显示副本）
# 读谱面 storage 历史最高分（字段不存在 → data get 失败 → store result 写 0，安全默认）
$execute store result score #hs_old play_state run data get storage rhythm_axe:maps.$(mapid) highest_score
# ★ 自动模式（2026-08-09）：auto 不覆盖最高分——最高记录显示历史值，不写回 storage
execute if score auto play_state matches 1 run scoreboard players operation highest_score play_state = #hs_old play_state
# 手动模式：本局分数与历史最高分取大者 → 写入 play_state（结算显示用）
execute if score auto play_state matches 0 run scoreboard players operation highest_score play_state = score score_calculate
execute if score auto play_state matches 0 run scoreboard players operation highest_score play_state > #hs_old play_state
# 手动模式才写回谱面 storage（持久化）；auto 不写回（宏函数独立，score_calculate 是宏函数不能嵌 $execute）
execute if score auto play_state matches 0 run function rhythm_axe:play/end_of_game/save_highest with storage rhythm_axe:runtime

# 血量换算百分比（health / 谱面最大血量 × 100）
scoreboard players operation percentage_health score_calculate = health play_state
scoreboard players operation percentage_health score_calculate *= 100 const
execute store result score #max_health score_calculate run data get storage rhythm_axe:runtime health
scoreboard players operation percentage_health score_calculate /= #max_health score_calculate
