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

# ★ 2026-09-30 最高分改为「按玩家分别存储」（二维 storage rhythm_axe:scores.<玩家UUID>.<mapid>）
#   本图分数是全员共用的一套判定/分数（perfect/good/miss 都是全局伪玩家）⇒ 本局每位参与者各记一份。
#   比较与写入集中在 play/highscore/write_all（同时把「你的最高记录」写进 highest_score play_state 供结算显示）。
#   名单 runtime.hs_players 由 end_of_game 在 team leave 之前采集。
#   auto 不记榜（与旧行为一致）：write=0b ⇒ 只读取历史最高用于显示。
# ★ 2026-10-01 只有**跑完全部谱面**才记成绩：end_of_game 判定的 runtime.finished 为 0 ⇒ write=0b。
#   血量百分比（percentage_health）同期写入成绩条目，供排行榜给分数上色 —— 所以血量换算已上移到本段之前。
data modify storage rhythm_axe:prop mapid set from storage rhythm_axe:runtime mapid
execute store result storage rhythm_axe:prop score int 1 run scoreboard players get score score_calculate
execute store result storage rhythm_axe:prop health int 1 run scoreboard players get percentage_health score_calculate
data modify storage rhythm_axe:prop write set value 1b
execute if score auto play_state matches 1 run data modify storage rhythm_axe:prop write set value 0b
execute unless data storage rhythm_axe:runtime {finished:1b} run data modify storage rhythm_axe:prop write set value 0b
function rhythm_axe:play/highscore/write_all with storage rhythm_axe:prop
execute unless data storage rhythm_axe:runtime {finished:1b} run tellraw @a [{"text":"[排行榜] ","color":"gold"},{"text":"谱面没跑完（中途结束），本局成绩不予记录","color":"yellow"}]
data remove storage rhythm_axe:prop mapid
data remove storage rhythm_axe:prop score
data remove storage rhythm_axe:prop health
data remove storage rhythm_axe:prop write
data remove storage rhythm_axe:runtime hs_players

# 血量换算百分比（health / 谱面最大血量 × 100）
# ★ 2026-09-13 先清零再读（同 health / #tp_flag 的 store result 残留问题）：谱面未定义 health 时
#   store 失败会让 #max_health 带着上一局的脏值 → 百分比乱；现在归 0 并跳过除法（除 0 会被游戏拒绝）
# ★ 2026-10-01 本段**上移到写榜之前**：成绩条目要连血量百分比一起存（排行榜按它给分数上色）
scoreboard players set percentage_health score_calculate 0
scoreboard players set #max_health score_calculate 0
scoreboard players operation percentage_health score_calculate = health play_state
scoreboard players operation percentage_health score_calculate *= 100 const
execute store result score #max_health score_calculate run data get storage rhythm_axe:runtime health
execute if score #max_health score_calculate matches 1.. run scoreboard players operation percentage_health score_calculate /= #max_health score_calculate
